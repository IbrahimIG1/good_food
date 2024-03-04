import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/controller/card_controller.dart';
import 'package:food_delivery_app/data/model/product_model.dart';
import 'package:food_delivery_app/data/reposetory/popular_product_repo.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = []; //  recepion save data from api

  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoading = false; // circle progress indicator
  bool get isLoading => _isLoading;

  //  get data from api
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    print("response is ${response.statusCode.toString()}");
    print("response is ${response.statusText.toString()}");
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Products.fromJson(response.body).products);
      // print(_popularProductList.length);
      _isLoading = true;
      update();
      print('getData Done in controller ');
    }
  }

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  //  set count item
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = cheakQuantity(_quantity + 1);
    } else {
      _quantity = cheakQuantity(_quantity - 1);
    }
    update();
  }

  // cheak Quantity to no zero and no negative number in item count
  int cheakQuantity(int quantity) {
    if (_inCartItems + quantity > 20) {
      Get.snackbar('Item Count', ' 20 Is beggest number',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else if (_inCartItems + quantity < 0) {
      Get.snackbar('Item Count', 'Zero Is least number',
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      _inCartItems = 0;
      return 0;
    } else {
      return quantity;
    }
  }

  // reset all variable to Initial cases
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

  late CartController
      _cardController; // Get instance to can connect with cart Controller method

  //  add Items in cart Model to show item Numbers on cart Icon like notification
  void addItem(ProductModel productModel) {
    _cardController.addItems(
        productModel: productModel,
        quantity:
            _quantity); //  Pass Product Model To Cart Controller To Add Items In intems map
    _quantity = 0;
    _inCartItems = _cardController.getQuantity(productModel);
    print('added in items ');
    update();
  }

  // function to get all items to show on cart Icon like notification
  int get allItems {
    return _cardController.allItems;
  }
}
