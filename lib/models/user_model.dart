import 'dart:convert';

import 'package:intelligentapp/models/addressModel.dart';
import 'package:intelligentapp/models/companyModel.dart';

class UserModel {
  late String id;
  late String name;
  late String username;
  late String email;
  late AddressModel address;
  late String phone;
  late String website;
  late CompanyModel company;

  UserModel();

  UserModel.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    name = jsonMap['name'];
    email = jsonMap['email'];
    phone = jsonMap['phone'];
    address = AddressModel.fromJSON(jsonMap['address']);
    username = jsonMap['username'];
    phone = jsonMap['phone'];
    website = jsonMap['website'];
    company = CompanyModel.fromJSON(jsonMap['company']);
  }
}
