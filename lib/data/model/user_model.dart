class UserModel {
  String? name;
  String? phone;
  String? email;
  String? id;
  int? orderCount;
  UserModel(
      {required name,
      required phone,
      required email,
      required id,
      required orderCount});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['f_name'],
      phone: json['phone'],
      email: json['email'],
      id: json['id'],
      orderCount: json['order_count'],
    );
  }
}
