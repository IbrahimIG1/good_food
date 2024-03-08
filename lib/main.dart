import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/controller/auth_controller.dart';
// import 'dart:io';
import 'package:food_delivery_app/data/controller/card_controller.dart';
import 'package:food_delivery_app/data/controller/dio_helper.dart';
import 'package:food_delivery_app/data/controller/popular_product_controller.dart';
import 'package:food_delivery_app/data/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/data/controller/user_controller.dart';
import 'package:food_delivery_app/data/helper/dependencies.dart' as dep;
import 'package:food_delivery_app/pages/auth/sign_in.dart';
import 'package:food_delivery_app/pages/auth/sign_up.dart';
import 'package:food_delivery_app/pages/splash/splash_screen.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  await DioHelper.init();

  // code to stability port
  // final server = await HttpServer.bind('127.0.0.1', 3306);
  // print('Server started on port ${server.port}');

  // await for (var request in server) {
  //   print(request.response);
  //   // Handle requests here
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData(); // call to get storage data
    Get.find<AuthController>().getUserToken(); // call to get storage data
    Get.find<PopularProductController>()
        .getPopularProductList(); // to call controller after splash screen

    Get.find<RecommendedProductController>()
        .getRecommendedProductList(); // to call controller after splash screen
    Get.find<UserController>().getUserInfo();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}
