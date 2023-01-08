import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:get/get.dart';

import '../data/controller/popular_product_controller.dart';
import '../utils/dimentions.dart';

class CartStack extends StatelessWidget {
  const CartStack({
    Key? key, required this.popularProduct,
  }) : super(key: key);
final PopularProductController popularProduct;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        AppIcon(
            icon: Icons.shopping_cart_outlined,
            iconSize: Dimentions.iconSize16),
        Get.find<PopularProductController>().inCartItems > 0
            ? Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: Dimentions.width20,
                  height: Dimentions.height20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                      child: Text(
                    popularProduct.inCartItems.toString(),
                    style: TextStyle(color: Colors.white,fontSize: Dimentions.font15),
                  )),
                ),
              )
            : 
            Container(),
      ],
    );
  }
}
