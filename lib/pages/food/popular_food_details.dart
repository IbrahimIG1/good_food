import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/controller/card_controller.dart';
import 'package:food_delivery_app/data/controller/popular_product_controller.dart';
import 'package:food_delivery_app/data/model/product_model.dart';
import 'package:food_delivery_app/pages/cart_icon_page.dart';
import 'package:food_delivery_app/pages/home/food_page_body.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expendable_text_widget.dart';
import 'package:food_delivery_app/widgets/navbar_container.dart';
import 'package:food_delivery_app/widgets/navigation_buttons.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/cart_data/cart_data_service.dart';
import '../../widgets/cart_stack.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetails extends StatelessWidget {
  const PopularFoodDetails({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        Get.find<PopularProductController>().popularProductList[index];
    CartController cardController = Get.find<CartController>();
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), product);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //  Big Stack Image
          Positioned(
              right: 0,
              left: 0,
              child: Container(
                height: Dimentions.popularFoodImgSize,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          NetworkImage(AppConstants.IMAGE_URL + product.img!),
                      fit: BoxFit.cover),
                ),
              )),
          // Top Icons
          Positioned(
            top: Dimentions.height45,
            right: Dimentions.width20,
            left: Dimentions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconSize: Dimentions.iconSize16)),
                GetBuilder<PopularProductController>(builder: (popularProduct) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return CartPageIcon();
                      //   },
                      // )
                      // );
                    },
                    child: CartStack(
                      popularProduct: popularProduct,
                    ),
                  );
                }),
              ],
            ),
          ),
          //   Introduce Food
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              top: Dimentions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dimentions.height20,
                    horizontal: Dimentions.height10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimentions.radius15),
                        topRight: Radius.circular(Dimentions.radius15))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: product.name!, size: Dimentions.font26),
                      SizedBox(height: Dimentions.height10),
                      Row(
                        children: [
                          star(product.stars!),
                          SizedBox(width: Dimentions.width5),
                          SmallText(text: product.stars!.toString()),
                          SizedBox(width: Dimentions.width10),
                          SmallText(text: '1287 comments'),
                        ],
                      ),
                      SizedBox(height: Dimentions.height20),
                      rowIconAndText(true),
                      //  Introduce
                      SizedBox(height: Dimentions.height20),
                      BigText(text: 'Introduce'),
                      SizedBox(height: Dimentions.height20),
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpendableTextWidget(
                                  text: product.description!)))
                    ]),
              )),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProductController) {
        return NavBarContainer(
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimentions.radius20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          popularProductController.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor)),
                    SizedBox(width: Dimentions.width10 / 2),
                    BigText(
                        text: popularProductController.inCartItems.toString()),
                    SizedBox(width: Dimentions.width10 / 2),
                    InkWell(
                        onTap: () {
                          popularProductController.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor)),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  popularProductController.addItem(product);
                  popularProductController.allItems;
                  Get.appUpdate();  //  update state (update UI)

                  
                  // CartDataService(await SharedPreferences.getInstance())
                  // .addCartData(cardController.cartList);
                  // cardController.cardRepo
                  //     .addCartListToShared(cardController.cartList);
                },
                child: NavButton(
                  widget: BigText(
                    text: popularProductController.inCartItems == 0
                        ? '\$ ${product.price!} | Add to card'
                        : '\$${product.price! * popularProductController.inCartItems} | Add to card',
                    color: Colors.white,
                  ),
                  buttonColor: AppColors.mainColor,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
