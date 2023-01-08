import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/controller/card_controller.dart';
import 'package:food_delivery_app/data/model/product_model.dart';
import 'package:food_delivery_app/data/reposetory/popular_product_repo.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Products.fromJson(response.body).products);
      // print(_popularProductList.length);
      _isLoading = true;
      update();
    }
  }

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = cheakQuantity(++_quantity);
    } else {
      _quantity = cheakQuantity(--_quantity);
    }
    update();
  }

  int cheakQuantity(int quantity) {
    if (inCartItems > 20) {
      Get.snackbar('Item Count', ' 20 Is beggest number',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else if (inCartItems < 0) {
      Get.snackbar('Item Count', 'Zero Is least number',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 0;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cardController, ProductModel product) {
    _quantity = 0;
    _inCartItems = 0;
    _cardController =
        cardController; // access to The once CartController after initialize in initProduct whan popular product UI
    bool exist = false;
    exist = _cardController.isExist(product); //  chek product in cart or not
    if (exist) {
      _inCartItems = _cardController
          .getQuantity(product); // if product in cart take the last quantity
    }
  }

  late CartController _cardController;
  void addItem(ProductModel productModel) {
    if (_quantity > 0) {
      _cardController.addItems(
          productModel: productModel,
          quantity:_quantity); //  Pass Product Model To Cart Controller To Add Items In intems map
      _quantity = 0;
      _inCartItems = _cardController.getQuantity(productModel);
      print('added in items ');
    } else {
      Get.snackbar('Item Count', 'You should at least add an item in the card',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
  }

  // int get allItems {
  //   return _cardController.allItems();
  // }
}
