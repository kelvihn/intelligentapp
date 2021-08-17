import 'dart:convert';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intelligentapp/models/user_model.dart';
import 'package:intelligentapp/views/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  StringConstants constants = new StringConstants();
  void insertDataFromApi(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_list', json.encode(json.decode(data)));
  }

  Future<List<UserModel>> fetchAllUsers() async {
    final Uri url = Uri.parse('${constants.baseUrl}users');
    final client = new http.Client();
    final response = await client.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
    });
    insertDataFromApi(response.body);
    List<UserModel> users = List.from(json.decode(response.body))
        .map((element) => UserModel.fromJSON(element))
        .toList();

    return users;
  }

  Future<UserModel> fetchUserById({required id}) async {
    final Uri url = Uri.parse('${constants.baseUrl}users/$id');
    final client = new http.Client();
    final response = await client.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
    });
    UserModel user = UserModel.fromJSON(json.decode(response.body));
    return user;
  }
}
