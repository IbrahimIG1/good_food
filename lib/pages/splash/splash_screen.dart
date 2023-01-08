import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/shared_packages/navigators.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import '../home/main_food_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);

    Timer(Duration(seconds: 3),
        () => navigateAndReplace(context, MainFoodPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset('assets/image/logo part 1.png',
                      width: Dimentions.width10 * 25))),
          Center(
              child: Image.asset('assets/image/logo part 2.png',
                  width: Dimentions.width10 * 25)),
        ],
      ),
    );
  }
}
