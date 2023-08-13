import 'dart:convert';
import 'package:food_delivery_app/data/model/card_model.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});
  List<String> cart = []; // the data which will save in sharedprefrence
  List<String> cartHistory = [];

  // Add Data To shared Preference
  void addCartListToShared(List<CartModel> cartModel) {
    cart = [];
    cartModel.forEach((element) {
      return cart.add(jsonEncode(element
          .toJson())); // Convert The CartMode To String Because Save It In Shared prefs
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    print('addCartListToShared Done');
    print(
        "add to shared => ${sharedPreferences.getStringList(AppConstants.CART_LIST)}");
    getCartList();
  }

  //  Get Data From shared Preference
  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    print("carts = ${carts.toString()}");
    List<CartModel> cartList = [];

    carts.forEach((element) {
      cartList.add(CartModel.fromJson(
          jsonDecode(element))); // jsonDecode convert from json to object
    });
    print("cartList = ${cartList.toString()}");

    print('getCartList from Shared Done');
    // print('cartList => ${cartModelList[0].dateTime}');
    return cartList;
  }

  // add Cart History to SharedPreference and cartHistoryList
  void addToCartHistoryList() {
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
  }
}
