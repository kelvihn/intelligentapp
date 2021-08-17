import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intelligentapp/api/apiService.dart';
import 'package:intelligentapp/models/user_model.dart';
import 'package:intelligentapp/views/constants/widgets/userTile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  ApiService api = new ApiService();
  late List<UserModel> userList;
  String query = "";
  TextEditingController searchController = new TextEditingController();

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

    setState(() {
      _connectionStatus = result.toString();
    });
    if (result.toString() == 'ConnectivityResult.none') {
      getFromDevice().then((value) {
        setState(() {
          userList = value;
        });
      });
    } else {
      api.fetchAllUsers().then((value) {
        setState(() {
          userList = value;
        });
      });
    }
  }

  @override
  void initState() {
    initConnectivity();
    super.initState();
  }
  /*
 =>
          user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.email.toLowerCase().contains(query.toLowerCase())).toList();
  */

  buildSuggestions(String query) {
    final List<UserModel> searchList = query.isEmpty
        ? []
        : userList.where((UserModel user) {
            String _getEmail = user.email.toLowerCase();
            String _query = query.toLowerCase();
            String _getName = user.name.toLowerCase();
            bool matchesEmail = _getEmail.contains(_query);
            bool matchesName = _getName.contains(_query);

            return (matchesEmail || matchesName);
          }).toList();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: searchList.length,
        itemBuilder: (builder, int index) {
          UserModel user = searchList[index];
          return UserTile(
            user: user,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            autofocus: true,
            decoration:
                InputDecoration.collapsed(hintText: 'Type Something...'),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: buildSuggestions(query),
          )
        ],
      )),
    );
  }
}
