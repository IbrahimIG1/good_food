import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/controller/auth_controller.dart';
import 'package:food_delivery_app/data/controller/card_controller.dart';
import 'package:food_delivery_app/data/controller/location_controller.dart';
import 'package:food_delivery_app/data/controller/popular_product_controller.dart';
import 'package:food_delivery_app/data/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/data/controller/user_controller.dart';
import 'package:food_delivery_app/data/reposetory/auth_repo.dart';
import 'package:food_delivery_app/data/reposetory/card_repo.dart';
import 'package:food_delivery_app/data/reposetory/location_repo.dart';
import 'package:food_delivery_app/data/reposetory/popular_product_repo.dart';
import 'package:food_delivery_app/data/reposetory/recommended_product_repo.dart';
import 'package:food_delivery_app/data/reposetory/user_repo.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //api Client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //Repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(),sharedPreferences: Get.find()));


  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  // Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}
