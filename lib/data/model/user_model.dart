class UserModel {
  String name;
  String phone;
  String email;
  int id;
  int orderCount;
  UserModel(
      {required this.name,
      required this.phone,
      required this.email,
      required this.id,
      required this.orderCount});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    print('UserModel fromJson Start');
    return UserModel(
      name: json['f_name'],
      phone: json['phone'],
      email: json['email'],
      id: json['id'],
      orderCount: json['order_count'],
    );
  }
}
