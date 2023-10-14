import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/cart_page/cart_history.dart';
import 'package:food_delivery_app/pages/cart_page/cart_page.dart';
import 'package:food_delivery_app/pages/home/food_page_body.dart';
import 'package:food_delivery_app/utils/colors.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

List<Widget> buildPage = [
  FoodPageBody(),
  Container(
    child: Text('Archive'),
  ),
  CartHistoryScreen(),
  Container(
    child: Text('Done'),
  ),
];
int navIndex = 0;

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
