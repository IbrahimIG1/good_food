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
    var time = DateTime.now().toString();
    cart = [];
    cartModel.forEach((element) {
      element.dateTime =
          time; // set new time to get all of items oreder with the same time minute and seconds
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
    // print("carts = ${carts.toString()}");
    List<CartModel> cartList = [];

    carts.forEach((element) {
      cartList.add(CartModel.fromJson(
          jsonDecode(element))); // jsonDecode convert from json to object
    });
    // print("cartList = ${cartList[0].toString()}");

    print('getCartList from Shared Done');
    // print('cartList => ${cartModelList[0].dateTime}');
    return cartList;
  }

  //  get history data from storage sharedprefs
  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartHistoryList = [];
    cartHistory.forEach((element) {
      cartHistoryList.add(CartModel.fromJson(jsonDecode(
          element))); //  to convert from string object to cartModel object to return
    });
    return cartHistoryList;
  }

  // add Cart History to SharedPreference and cartHistoryList (ChekOut)
  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    // add orders from cart to cartHistory to show it in cartScreen
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
      print('data in history' + cartHistory[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    print('the lenght of history list is ' +
        getCartHistoryList().length.toString());
  }

  // remove cartList from sharedprefs after check out
  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
