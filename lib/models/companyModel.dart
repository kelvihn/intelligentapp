class CompanyModel {
  late String name;
  late String catchPhrase;
  late String bs;

  CompanyModel();

  CompanyModel.fromJSON(Map<String, dynamic> jsonMap) {
    name = jsonMap['name'];
    catchPhrase = jsonMap['catchPhrase'];
    bs = jsonMap['bs'];
  }
}
