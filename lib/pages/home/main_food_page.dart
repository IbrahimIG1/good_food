import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/controller/popular_product_controller.dart';
import 'package:food_delivery_app/data/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/pages/account/account.dart';
import 'package:food_delivery_app/pages/auth/sign_in.dart';
import 'package:food_delivery_app/pages/auth/sign_up.dart';
import 'package:food_delivery_app/pages/cart_page/cart_history.dart';
import 'package:food_delivery_app/pages/cart_page/cart_page.dart';
import 'package:food_delivery_app/pages/food/recommended_food_details/recommended_food_details.dart';
import 'package:food_delivery_app/pages/home/food_page_body.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

List<Widget> buildPage = [
  FoodPageBody(),
  Container(
    child: Center(child: Text("History Page")),
  ),
  CartHistoryScreen(),
  AccountPage()
];
int navIndex = 0;

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    // refresh indicator get data when swip screen down to refresh
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _loadResource(),
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: Scaffold(
        body: buildPage[navIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                navIndex = value;
              });
            },
            currentIndex: navIndex,
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: Colors.amber,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive), label: 'archive'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'cart'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'info'),
            ]),
      ),
    );
  }
}
