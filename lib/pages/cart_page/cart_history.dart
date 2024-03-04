// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/data/controller/card_controller.dart';
// import 'package:food_delivery_app/utils/colors.dart';
// import 'package:food_delivery_app/widgets/app_icon.dart';
// import 'package:food_delivery_app/widgets/big_text.dart';
// import 'package:get/get.dart';

// class CartHistory extends StatelessWidget {
//   const CartHistory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // List getCartHistoryList = Get.find<CartController>().getCartHistoryList();
//     Map<String, int> cartItemPerOreder = Map();
//     for (int x = 0; x < getCartHistoryList.length; x++) {
//       if (cartItemPerOreder.containsKey(getCartHistoryList[x].time!)) {
//         cartItemPerOreder.update(
//           getCartHistoryList[x].time!,
//           (value) => ++value,
//         );
//       } else {
//         cartItemPerOreder.putIfAbsent(
//           getCartHistoryList[x].time!,
//           () => 1,
//         );
//       }
//     }
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Container(
//               color: AppColors.mainColor,
//               height: 70,
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     BigText(text: 'Your Cart History'),
//                     AppIcon(
//                         icon: Icons.shopping_cart,
//                         backgroundColor: Colors.transparent)
//                   ]),
//             ),
//             Expanded(
//                 child: ListView(
//               children: [
//                 for (int x = 0; x < getCartHistoryList.length; x++)
//                   Column(
//                     children: [
//                       BigText(text: 'day/month/year'),
//                       Row(
//                         children: [
//                           Wrap(
//                             direction: Axis.horizontal,
//                             children: [
//                               Image.asset('assets/image/food1.png', width: 100),
//                               Image.asset('assets/image/food1.png', width: 100),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/no_data_page.dart';
import 'package:food_delivery_app/data/controller/card_controller.dart';
import 'package:food_delivery_app/data/model/card_model.dart';
import 'package:food_delivery_app/pages/cart_icon_page.dart';
import 'package:food_delivery_app/shared_packages/navigators.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // reversed : to revers index in list to show last date in  first result
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemPerOrdre =
        Map(); // have dateTime as a key and  number of repeat it as a value

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemPerOrdre.containsKey(getCartHistoryList[i].dateTime)) {
        cartItemPerOrdre.update(
            getCartHistoryList[i].dateTime!, (value) => ++value);
      } else {
        cartItemPerOrdre.putIfAbsent(getCartHistoryList[i].dateTime!, () => 1);
      }
    }
    // convert map to list and save value
    List<int> cartOrderTimeValue() {
      return cartItemPerOrdre.entries.map((e) => e.value).toList();
    }

    // convert map to list and save key
    List<String> cartOrderTimeKey() {
      return cartItemPerOrdre.entries.map((e) => e.key).toList();
    }

    List<int> orderTime =
        cartOrderTimeValue(); // the value number of reapet dateTime of orders
    List<String> orderDate = cartOrderTimeKey(); // the Key dateTIme of orders
    var listCounter = 0;
    Widget timeWidget(int index) {
      var outPutDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss')
            .parse(getCartHistoryList[listCounter].dateTime!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outPutFormat = DateFormat('MM-dd-yyy HH:mm a');
        outPutDate = outPutFormat.format(inputDate);
      } // Date Time Format Variables

      return BigText(text: outPutDate);
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // app Bar section

            Container(
              color: AppColors.mainColor,
              width: double.maxFinite,
              height: Dimentions.height10 * 10,
              child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BigText(
                      text: 'Your cart history',
                      color: Colors.white,
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: AppColors.mainColor,
                    ),
                    InkWell(
                        onTap: () {
                          Get.find<CartController>().removeCartHistory();
                        },
                        child: AppIcon(icon: Icons.delete))
                  ]),
            ),

            GetBuilder<CartController>(builder: (cartcontroller) {
              return cartcontroller.getCartHistoryList().isNotEmpty
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: Dimentions.height20,
                            left: Dimentions.height20,
                            right: Dimentions.height20),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          // ListView has padding by default
                          child: ListView(
                            children: [
                              for (int i = 0; i < orderTime.length; i++)
                                Container(
                                  height: Dimentions.height120 +
                                      Dimentions.height10, // parent height
                                  margin: EdgeInsets.only(
                                      bottom: Dimentions.height20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      timeWidget(listCounter),
                                      SizedBox(
                                        height: Dimentions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //  Wrap : reapet list of pbjects
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children:
                                                // this list generate is a for loop this lenght is orderTime[i].
                                                // orderTime[i] is list have how many items in order (order have 3 kind different).
                                                // getCartHistoryList[i] have all of orders history ,index is about all of them .
                                                // order in orderTime[i] list have index , and the same order in getCartHistoryList[i] have another index
                                                // so create listCounter and increase it continuously to keep up increase in getCartHistoryList[i] index and get next order when orderTime[i] index has start from 0 again

                                                List.generate(orderTime[i],
                                                    (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              // print('index = $index  listCounter = $listCounter  orderTime[i] = ${orderTime[i]}');
                                              return index <=
                                                      2 // to show 3 image only (overflowed exception)
                                                  ?
                                                  //  orders food image
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: Dimentions
                                                                  .width10 /
                                                              2),
                                                      width:
                                                          Dimentions.width120 /
                                                                  2 +
                                                              10,
                                                      height:
                                                          Dimentions.height120 /
                                                                  2 +
                                                              10,
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(AppConstants
                                                                    .IMAGE_URL +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!),
                                                          ),
                                                          borderRadius: BorderRadius
                                                              .circular(Dimentions
                                                                      .radius15 /
                                                                  2)),
                                                    )
                                                  : Container();
                                            }),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SmallText(
                                                  text: 'Total',
                                                  color: AppColors.titleColor),
                                              SizedBox(
                                                height: Dimentions.height10,
                                              ),
                                              BigText(
                                                  text:
                                                      '${orderTime[i].toString()} Items',
                                                  color: AppColors.titleColor),
                                              SizedBox(
                                                height: Dimentions.height10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  List<String> orderTime =
                                                      cartOrderTimeKey();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  //  add order which clicked on it in new map to pass to items map to show again in cart screen
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .dateTime ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                        getCartHistoryList[j]
                                                            .id!,
                                                        () =>
                                                            CartModel.fromJson(
                                                          // Parses the string and returns the resulting Json object.
                                                          jsonDecode(
                                                            // Converts [object] to a JSON string.
                                                            jsonEncode(
                                                                getCartHistoryList[
                                                                    j]),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                  print('Get here');
                                                  Get.find<CartController>()
                                                      .setItemsHis = moreOrder;
                                                  Get.find<CartController>()
                                                      .addToCartIconList();
                                                  navigateAndReplace(
                                                      context, CartPageIcon());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          Dimentions.height10 /
                                                              2,
                                                      horizontal:
                                                          Dimentions.height10),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimentions
                                                                  .radius15 /
                                                              3),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .mainColor)),
                                                  child: Text(
                                                    'one more',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .mainColor),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: NoDataPage(
                        text: 'You didn\'t Buy anything yet',
                        imgPath: 'assets/image/empty_box.png',
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }
}
