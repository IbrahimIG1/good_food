import 'dart:convert';

import 'package:food_delivery_app/data/cart_data/cart_data_implement.dart';
import 'package:food_delivery_app/data/model/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartDataService implements ICartData 
{
  CartDataService(this.sharedPreferences);
  final SharedPreferences sharedPreferences;
  List<String>cartDataString=[];
  @override
  void addCartData(List<CartModel> data) {
    data.forEach((element) 
    {
      // cartDataString.add(jsonEncode(element));
      cartDataString.add(element.toString());
     });
     sharedPreferences.setStringList('cartData', cartDataString);
     print('setStringList => Done');
  }

  @override
  List<CartModel> getCartData() {
    List<String>getCartDataList=[];
    if(sharedPreferences.containsKey('cartData'))
    {
    getCartDataList = sharedPreferences.getStringList('cartData')!;
    }
    List<CartModel>modelDataList =[];
    getCartDataList.forEach((element) 
    {
      modelDataList.add(CartModel.fromJson(jsonDecode(element)));
     });
    return modelDataList;
  }
  
}