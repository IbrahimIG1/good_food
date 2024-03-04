// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/data/model/card_model.dart';
// import 'package:food_delivery_app/data/model/product_model.dart';
// import 'package:food_delivery_app/data/reposetory/card_repo.dart';
// import 'package:food_delivery_app/utils/colors.dart';
// import 'package:get/get.dart';

// class CardController extends GetxController {
//   CardController({required this.cardRepo});
//   final CardRepo cardRepo;
//   Map<int, List<CartModel>> _items = {};
//   Map<int, CartModel> get items => _items;
//   void addItems(ProductModel product, quantity) {
//     if (_items.containsKey(product.id!)) {
//       _items.update(product.id!, (value) {
//         return CartModel(
//             id: value.id!,
//             isExist: true,
//             name: value.name!,
//             price: value.price!,
//             img: value.img!,
//             quantity: quantity,
//             dateTime: DateTime.now().toString());
//       });
//     } else {
//       _items.putIfAbsent(product.id!, () {
//         return CartModel(
//             id: product.id!,
//             isExist: true,
//             name: product.name!,
//             img: product.img!,
//             price: product.price!,
//             quantity: quantity,
//             dateTime: DateTime.now().toString());
//       });
//     }
//   }

//   bool isExist(ProductModel productModel) {
//     if (_items.containsKey(productModel.id!)) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   int allItems() {
//     int totalQuantity = 0;
//     _items.forEach((key, value) {
//       totalQuantity = totalQuantity + value.quantity!;
//     });
//     return totalQuantity;
//   }

//   int _quantity = 0;
//   int get quantity => _quantity;
//   void setQuantity(bool isIncrement) {
//     if (isIncrement) {
//       _quantity = cheakQuantity(++_quantity);
//     } else {
//       _quantity = cheakQuantity(--_quantity);
//     }
//     update();
//   }

//   int cheakQuantity(int quantity) {
//     if (quantity > 20) {
//       Get.snackbar('Item Count', ' 20 Is beggest number',
//           backgroundColor: AppColors.mainColor, colorText: Colors.white);
//       return 20;
//     } else if (quantity < 0) {
//       Get.snackbar('Item Count', 'Zero Is least number',
//           backgroundColor: AppColors.mainColor, colorText: Colors.white);
//       return 0;
//     } else {
//       return quantity;
//     }
//   }

//   List<CartModel> cartList = [];
//   int allPrices = 0;
//   addCartList() {
//     cartList = [];
//     allPrices = 0;
//     _items.forEach((key, value) {
//       cartList.add(value);
//       allPrices = allPrices + value.price! * value.quantity!;
//     });
//   }

//   List<CartModel> storageItems = [];
//   List<CartModel> getCartList() {
//     setCart = cardRepo.getCartList();
//     return storageItems;
//   }

//   set setCart(List<CartModel> items) {
//     storageItems = items;
//     print('lenght Of Cart Items is ${storageItems.length}');
//     for (var i = 0; i < storageItems.length; i++) {
//       _items.putIfAbsent(storageItems[i].id!, () => storageItems[i]);
//     }
//   }

//   // void updateDate(List<CartModel> cartModel) {
//   //   cartModel.forEach((element) {
//   //     print('before update ${element.dateTime}');
//   //     element.dateTime = DateTime.now().toString();
//   //     print('after update ${element.dateTime}');
//   //   });
//   // }
//   List getCartHistoryList() {
//     return cardRepo.getCartList();
//   }
// }
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/card_model.dart';
import 'package:food_delivery_app/data/reposetory/card_repo.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../model/product_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  String? oldTime;
  List<CartModel> storageItems = []; // only for storage and sharedprefrences

  // take data from product model not from UI
  void addItems({required ProductModel productModel, required int quantity}) {
    //  This condition to can add quantity for same item
    var totalQuantity = 0;
    if (_items.containsKey(productModel.id)) {
      _items.update(productModel.id!, (value) {
        // oldTime = value.dateTime == DateTime.now().toString()
        //     ? DateTime.now().toString()
        //     : value.dateTime;
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            isExist: true,
            name: value.name,
            img: value.img,
            price: value.price,
            quantity: value.quantity! +
                quantity, // Add new quantity to old one which added in (putIfAbsent)
            dateTime: oldTime,
            // dateTime: DateTime.now().toString(),
            product: productModel);
      });
      if (totalQuantity <= 0) {
        _items.remove(productModel.id);
      }
    } else {
      //  putIfAbsent Add Id (Item) Once
      if (quantity > 0) {
        _items.putIfAbsent(productModel.id!, () {
          return CartModel(
              id: productModel.id,
              isExist: true,
              name: productModel.name,
              img: productModel.img,
              price: productModel.price,
              quantity: quantity,
              dateTime: oldTime,
              // dateTime: DateTime.now().toString(),
              product: productModel);
        });
      } else {
        Get.snackbar(
            'Item Count', 'You should at least add an item in the card',
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepo.addCartListToShared(getItems);
    update();
  }

  // Chek Items in cart or not
  bool isExist(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  // take the last product quantity if product in cart to show in UI
  int getQuantity(ProductModel product) {
    int quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        // this condition for chek it the same product or not to take the right quantity
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  List<CartModel> cartList = [];
  //  get all items count
  int get allItems {
    var totalQuantity = 0;
    cartList = [];
    _items.forEach((key, value) {
      cartList.add(value);
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get allAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });

    return total;
  }

  //   this method will only call first time launch the app to put storage data in _items Map
  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList(); // set items in storageItems List
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;

    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!,
          () => storageItems[i]); // put storage Data in map
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  //  clear data from cartIconScreen
  void clear() {
    print('cleared');
    _items = {};
    update();
    print('update');
  }

  // get history data to show in cart History screen
  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItemsHis(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartIconList() // save data in sharedprefrence again to edite it
  {
    cartRepo.addCartListToShared(getItems);

    update();
  }

  void removeCartHistory() {
    cartRepo.removeCartHistory();
    update();
    print('Remove Done');
  }
}
