import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intelligentapp/api/apiService.dart';
import 'package:intelligentapp/models/user_model.dart';
import 'package:intelligentapp/views/constants/widgets/userTile.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ApiService api = new ApiService();
  timerr() {
    const oneSec = Duration(seconds: 3);
    Timer.periodic(oneSec, (Timer t) => print(_connectionStatus));
  }

  Future<List<UserModel>> getFromDevice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final users = prefs.getString('user_list');
    List<UserModel> userList;
    if (users == null) {
      print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      print('no key for users');
      userList = <UserModel>[];
    } else {
      print(users);
      userList = List.from(json.decode(users))
          .map((element) => UserModel.fromJSON(element))
          .toList();
    }
    return userList;
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    //getFromDevice();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
    if (_connectionStatus == 'ConnectivityResult.none') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Your device is offline'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('User List'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: _connectionStatus == 'Unknown'
                  ? builderLoader()
                  : _connectionStatus == 'ConnectivityResult.wifi'
                      ? buildViewWithInternet()
                      : _connectionStatus == 'ConnectivityResult.mobile'
                          ? buildViewWithInternet()
                          : buildViewWithoutInternet())),
    );
  }

  builderLoader() {
    return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: CircularProgressIndicator());
  }

  buildViewWithInternet() {
    print('built from internet');
    return FutureBuilder<List<UserModel>>(
        future: api.fetchAllUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      UserModel user = snapshot.data[index];
                      return UserTile(user: user);
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length));
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text('an error occured');
          }
          return builderLoader();
        });
  }

  buildViewWithoutInternet() {
    print('built from device');
    return FutureBuilder<List<UserModel>>(
        future: getFromDevice(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  child: Text('Please check your internet connection'));
            } else {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        UserModel user = snapshot.data[index];
                        return UserTile(user: user);
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length));
            }
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                child: Text('Please check your internet connection'));
          }
          return builderLoader();
        });
  }
}
