import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/controller/card_controller.dart';
import 'package:food_delivery_app/data/controller/popular_product_controller.dart';
import 'package:food_delivery_app/data/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/data/model/product_model.dart';
import 'package:food_delivery_app/pages/cart_icon_page.dart';
import 'package:food_delivery_app/pages/food/recommended_food_details/bottom_preferred_size.dart';
import 'package:food_delivery_app/pages/food/recommended_food_details/flexible_image_space.dart';
import 'package:food_delivery_app/shared_packages/navigators.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expendable_text_widget.dart';
import 'package:food_delivery_app/widgets/navbar_container.dart';
import 'package:food_delivery_app/widgets/navigation_buttons.dart';
import 'package:get/get.dart';

import '../../../widgets/cart_stack.dart';

class RecommendedFoodDetails extends StatelessWidget {
  const RecommendedFoodDetails({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        Get.find<RecommendedProductController>().recommendedProductList[index];
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), product);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: Dimentions.height10 * 7,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppIcon(
                        icon: Icons.clear, iconSize: Dimentions.iconSize16)),
                GetBuilder<PopularProductController>(builder: (popularProduct) {
                  return InkWell(
                    onTap: ()
                    {
                      navigateTo(context, CartPageIcon());
                    },
                    child: CartStack(
                      popularProduct: popularProduct,
                    ),
                  );
                }),
              ],
            ),
            pinned: true,
            bottom: PreferredSize(
              child:
                  BottomPreferredSize(), //  title Bottom Preferred Size Class
              preferredSize: Size.fromHeight(Dimentions.height20),
            ),
            expandedHeight: Dimentions.height10 * 30,
            flexibleSpace: FlexibleSpaceBar(
              background: FlexibleImageSpace(
                image: AppConstants.IMAGE_URL + product.img!,
              ), //  Flexible Image Space class
            ),
            backgroundColor: AppColors.yellowColor,
          ),
          //  Body Content
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                left: Dimentions.width20,
                right: Dimentions.width20,
              ),
              child: ExpendableTextWidget(text: product.description!),
            ),
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.mainColor),
                    child: InkWell(
                      onTap: () {
                        popularProduct.setQuantity(false);
                      },
                      child: AppIcon(
                        icon: Icons.remove,
                        iconSize: Dimentions.iconSize24,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    )),
                BigText(
                    text: '\$${product.price!} X ${popularProduct.inCartItems}'),
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.mainColor),
                    child: InkWell(
                      onTap: () {
                        popularProduct.setQuantity(true);
                      },
                      child: AppIcon(
                        icon: Icons.add,
                        iconSize: Dimentions.iconSize24,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    )),
              ],
            ),
            SizedBox(height: Dimentions.height20),
            NavBarContainer(
              widget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavButton(
                        widget: Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        ),
                        buttonColor: Colors.white),
                    InkWell(
                      onTap: () {
                        if (popularProduct.inCartItems > 0) {
                          popularProduct.addItem(product);
                          Get.appUpdate();
                        } else {
                          Get.snackbar('The quantity is very small',
                              'The minimum order quantity is one',
                              backgroundColor: AppColors.mainColor,
                              colorText: Colors.white);
                        }
                      },
                      child: NavButton(
                          widget: BigText(
                            text:
                                '\$ ${product.price! * popularProduct.inCartItems} | Add to card',
                            color: Colors.white,
                          ),
                          buttonColor: AppColors.mainColor),
                    )
                  ]),
            ),
          ],
        );
      }),
    );
  }
}
