class SignUpModel {
  String name;
  String phone;
  String password;
  String email;
  SignUpModel(
      {required this.name,
      required this.phone,
      required this.password,
      required this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['f_name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
