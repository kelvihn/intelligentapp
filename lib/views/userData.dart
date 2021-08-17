import 'package:flutter/material.dart';
import 'package:intelligentapp/api/apiService.dart';
import 'package:intelligentapp/models/user_model.dart';
import 'package:intelligentapp/views/constants/widgets/leadingWidget.dart';

class UserData extends StatefulWidget {
  final UserModel user;
  const UserData({Key? key, required this.user}) : super(key: key);

  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  ApiService api = new ApiService();
  late Future<UserModel> user;
  @override
  void initState() {
    //user = api.fetchUserById(id: widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Details'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                  child: Column(
                children: [
                  LeadingWidget(
                    height: 100,
                    width: 100,
                    iconSize: 50,
                  ),
                  SizedBox(height: 15),
                  Text('${widget.user.name}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'MontserratBold',
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                ],
              )),
              SizedBox(height: 30),
              Divider(),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_pin,
                          color: Theme.of(context).primaryColor),
                      SizedBox(width: 5),
                      Text('Address',
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                        '${widget.user.address.city + ' ' + widget.user.address.street + ' ' + widget.user.address.suite}'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Theme.of(context).primaryColor),
                      SizedBox(width: 5),
                      Text('Email',
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text('${widget.user.email}'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.call, color: Theme.of(context).primaryColor),
                      SizedBox(width: 5),
                      Text('Phone Number',
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text('${widget.user.phone}'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.web, color: Theme.of(context).primaryColor),
                      SizedBox(width: 5),
                      Text('Website',
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text('${widget.user.website}'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.work, color: Theme.of(context).primaryColor),
                      SizedBox(width: 5),
                      Text('Company',
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                        '${widget.user.company.name + ', ' + widget.user.company.catchPhrase}'),
                  )
                ],
              )
            ],
          ),
        )));
  }
}
