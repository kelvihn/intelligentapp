class AddressModel {
  late String street;
  late String suite;
  late String city;
  late String zipCode;

  AddressModel();

  AddressModel.fromJSON(Map<String, dynamic> jsonMap) {
    street = jsonMap['street'];
    suite = jsonMap['suite'];
    city = jsonMap['city'];
    zipCode = jsonMap['zipcode'];
  }
}
