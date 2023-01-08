import 'dart:convert';
import 'package:food_delivery_app/data/model/card_model.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  CartRepo(this.sharedPrefs);
  final SharedPreferences sharedPrefs;
  List<String> cart = [];
  List<String> cartHistory = [];

  // Add Data To shared Preference
  void addCartListToShared(List<CartModel> cartModel) {
    cart = [];
    cartModel.forEach((element) {
      return cart.add(jsonEncode(element
          .toJson())); // Convert The CartMode To String Because Save It In Shared prefs
    });
    sharedPrefs.setStringList(AppConstants.CART_LIST, cart);
    print('addCartListToShared Done');
    print("add to shared => ${cartModel.toString()}");
    getCartList();
  }

  //  Get Data From shared Preference
  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPrefs.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPrefs.getStringList(AppConstants.CART_LIST)!;
    }
    print("carts = ${carts.toString()}");
    List<CartModel> cartList = [];

    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
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
    sharedPrefs.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }
}
