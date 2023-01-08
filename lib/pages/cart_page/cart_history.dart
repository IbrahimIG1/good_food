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
