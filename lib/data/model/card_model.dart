import 'package:food_delivery_app/data/model/product_model.dart';

class CartModel {
  int? id;
  String? name;
  String? img;
  int? price;
  bool? isExist;
  int? quantity;
  String? dateTime;
  ProductModel? product;
  CartModel(
      {required this.id,
      required this.isExist,
      required this.name,
      required this.img,
      required this.price,
      required this.quantity,
      required this.dateTime,
      required this.product,});
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    price = json['price'];
    isExist = json['isExist'];
    quantity = json['quantity'];
    dateTime = json['time'];
    product = ProductModel.fromJson(json['products']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'price': price,
      'isExist': isExist,
      'quantity': quantity,
      'time': dateTime,
      'products' : product!.toJson()
    };
  }
}
