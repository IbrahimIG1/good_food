class SignInModel {
  String email;
  String password;
  String phone;
  SignInModel(
      {required this.email, required this.password, required this.phone});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    return data;
  }
}
