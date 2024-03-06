class AdressModel {
  late int _id;
  late String _adress;
  late String _adressType;
  late String _contactPersonName;
  late String _contactPersonNumber;
  late String _latitude;
  late String _logitude;

  AdressModel(
      {id,
      required adressType,
      adress,
      contactPersonName,
      contactPersonNumber,
      latitude,
      logitude}) {
    _id = id;
    _adressType = adressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _adress = adress;
    _latitude = latitude;
    _logitude = logitude;
  }

  // int get id => _id;
  String get adress => _adress;
  String get adressType => _adressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;
  String get latitude => _latitude;
  String get lagitude => _logitude;

  AdressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _adress = json['adress'];
    _adressType = json['adress_type'] ?? "";
    _contactPersonName = json['contact_person_name'] ?? "";
    _contactPersonNumber = json['contact_person_number'] ?? "";
    _latitude = json['latitude'];
    _logitude = json['logitude'];
  }
}
