class CartModel {
  int? id;
  String? name;
  String? img;
  int? price;
  bool? isExist;
  int? quantity;
  String? dateTime;
  CartModel(
      {required this.id,
      required this.isExist,
      required this.name,
      required this.img,
      required this.price,
      required this.quantity,
      required this.dateTime});
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    price = json['price'];
    isExist = json['isExist'];
    quantity = json['quantity'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'price': price,
      'isExist': isExist,
      'quantity': quantity,
      'dateTime': dateTime,
    };
  }
}
