// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/data/controller/popular_product_controller.dart';

// import 'package:food_delivery_app/pages/home/main_food_page.dart';
// import 'package:food_delivery_app/shared_packages/navigators.dart';
// import 'package:food_delivery_app/utils/app_constants.dart';
// import 'package:food_delivery_app/utils/colors.dart';
// import 'package:food_delivery_app/utils/dimentions.dart';
// import 'package:food_delivery_app/widgets/app_icon.dart';
// import 'package:food_delivery_app/widgets/big_text.dart';
// import 'package:food_delivery_app/widgets/navbar_container.dart';
// import 'package:food_delivery_app/widgets/navigation_buttons.dart';
// import 'package:food_delivery_app/widgets/plus_minus_button.dart';
// import 'package:food_delivery_app/widgets/small_text.dart';
// import 'package:get/get.dart';

// import '../data/controller/card_controller.dart';

// class CartPageIcon extends StatelessWidget {
//   const CartPageIcon({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // PopularProductController popularController =
//     //     Get.find<PopularProductController>();
//     CartController cardController = Get.find<CartController>();
//     // cardController.addCartList();
//     // cardController.cartList =cardController.getCartList();
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     vertical: Dimentions.height20,
//                     horizontal: Dimentions.width10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: AppIcon(
//                           icon: Icons.arrow_back_ios,
//                           backgroundColor: AppColors.mainColor,
//                           iconColor: Colors.white),
//                     ),
//                     SizedBox(width: Dimentions.width10 * 10),
//                     InkWell(
//                       onTap: () {
//                         navigateAndReplace(context, MainFoodPage());
//                       },
//                       child: AppIcon(
//                           icon: Icons.home,
//                           backgroundColor: AppColors.mainColor,
//                           iconColor: Colors.white),
//                     ),
//                     AppIcon(
//                         icon: Icons.shopping_cart,
//                         backgroundColor: AppColors.mainColor,
//                         iconColor: Colors.white),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: GetBuilder<CartController>(builder: (cardController) {
//                   return ConditionalBuilder(
//                       condition: cardController.cartList.isNotEmpty,
//                       fallback: (context) =>
//                           Center(child: CircularProgressIndicator()),
//                       builder: (context) {
//                         return ListView.builder(
//                           itemBuilder: (context, index) {
//                             var cartList = cardController.cartList[index];

//                             return Padding(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: Dimentions.height10 / 2,
//                                   horizontal: Dimentions.width10),
//                               child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     //  image section
//                                     Container(
//                                         // margin: EdgeInsets.only(bottom: Dimentions.height10),
//                                         width: Dimentions.listViewImageSize,
//                                         height: Dimentions.listViewImageSize,
//                                         decoration: BoxDecoration(
//                                             color: Colors.white38,
//                                             borderRadius: BorderRadius.circular(
//                                                 Dimentions.radius15),
//                                             image: DecorationImage(
//                                                 fit: BoxFit.cover,
//                                                 image: NetworkImage(
//                                                     AppConstants.IMAGE_URL +
//                                                         cartList.img!)))),
//                                     Expanded(
//                                       child: Container(
//                                         height:
//                                             Dimentions.listViewTxtContainerSize,
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.only(
//                                                 topRight: Radius.circular(
//                                                     Dimentions.radius20),
//                                                 bottomRight: Radius.circular(
//                                                     Dimentions.radius20))),
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: Dimentions.width10,
//                                               right: Dimentions.width10),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               BigText(text: cartList.name!),
//                                               SizedBox(
//                                                   height: Dimentions.height10),
//                                               SmallText(text: 'spice'),
//                                               SizedBox(
//                                                   height: Dimentions.height10),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   BigText(
//                                                       text:
//                                                           '\$ ${cartList.price! * cartList.quantity!}'),
//                                                   plusMinusButton(
//                                                     quantity: cartList.quantity
//                                                         .toString(),
//                                                     minus: () {
//                                                       cardController
//                                                           .setQuantity(false);
//                                                     },
//                                                     plus: () {
//                                                       cardController
//                                                           .setQuantity(true);
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ]),
//                             );
//                           },
//                           itemCount: cardController._items.length,
//                         );
//                       });
//                 }),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: NavBarContainer(
//           widget: Padding(
//             padding: EdgeInsets.symmetric(horizontal: Dimentions.width10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(Dimentions.radius20)),
//                   child: BigText(text: "\$ ${cardController.allPrices}"),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     cardController.cardRepo.addToCartHistoryList();
//                     // print('click');
//                     // cardController.cardRepo.getCartList();
//                     // cardController.updateDate(cardController.cartList);
//                   },
//                   child: NavButton(
//                       widget: BigText(text: 'Check out', color: Colors.white),
//                       buttonColor: AppColors.mainColor),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
