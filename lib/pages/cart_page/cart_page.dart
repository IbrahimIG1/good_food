// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/data/controller/card_controller.dart';
// import 'package:food_delivery_app/data/model/card_model.dart';
// import 'package:food_delivery_app/utils/dimentions.dart';
// import 'package:get/get.dart';

// class CartPageScreen extends StatelessWidget {
//   CartPageScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CartController>(
//       builder: (controller) {
//         // img(controller.cartList);
//         return Center(
//           child: Container(
//             width: Dimentions.listViewImageSize,
//             height: Dimentions.listViewImageSize,
//             color: Colors.red,
//             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//             child: ListView.separated(
//               separatorBuilder: (context, index) => Container(
//                 height: 20,
//               ),
//               itemCount: 20,
//               itemBuilder: (context, index) {
//                 return Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       //  image section
//                       Container(
//                           // margin: EdgeInsets.only(bottom: Dimentions.height10),
//                           width: Dimentions.listViewImageSize,
//                           height: Dimentions.listViewImageSize,
//                           decoration: BoxDecoration(
//                             color: Colors.white38,
//                             borderRadius:
//                                 BorderRadius.circular(Dimentions.radius15),
//                             // image: DecorationImage(
//                             //     fit: BoxFit.cover,
//                             //     image: NetworkImage(lista[index]))
//                           )),
//                     ]);
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   List<String> lista = [];
//   void img(List<CartModel> model) {
//     model.forEach((element) {
//       lista.add(element.img!);
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

/****************************************************************************** */
