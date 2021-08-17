import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intelligentapp/views/userList.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Display Demo',
      theme: ThemeData(
        fontFamily: 'MontserratRegular',
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      home: UserList(),
    );
  }
}
