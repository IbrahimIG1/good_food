import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/validation_custom_snakbar.dart';
import 'package:food_delivery_app/data/controller/auth_controller.dart';
import 'package:food_delivery_app/data/controller/card_controller.dart';
import 'package:food_delivery_app/data/controller/user_controller.dart';
import 'package:food_delivery_app/data/model/user_model.dart';
import 'package:food_delivery_app/pages/auth/sign_in.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/pages/splash/splash_screen.dart';
import 'package:food_delivery_app/shared_packages/navigators.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});

  // Account Data UI Information
  late UserModel userModel;
  late List<Map> infoData = [
    {
      'icon': Icons.person,
      'text': "userModel.name",
      'color': AppColors.mainColor,
    },
    {
      'icon': Icons.phone_android,
      'text': "userModel.phone",
      'color': Colors.greenAccent
    },
    {
      'icon': Icons.email,
      'text': 'Info@gmail.com',
      'color': AppColors.yellowColor
    },
    {
      'icon': Icons.location_on,
      'text': 'address',
      'color': AppColors.yellowColor
    },
    {
      'icon': Icons.logout,
      'text': 'log out',
      'color': Colors.redAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    late List<String> userModelInfo = [
      userController.userModel.name,
      userController.userModel.phone,
      userController.userModel.email,
      userController.userModel.id.toString(),
      'Log Out'
    ];
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      print("Get _userLogged In IN IF Account Page ${_userLoggedIn}");
      print("Get User Info IN IF Account Page");
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
        ),
        backgroundColor: AppColors.mainColor,
        elevation: 6,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading
                ? Container(
                    padding: EdgeInsets.only(top: Dimentions.height20),
                    child: Column(
                      children: [
                        // Profile Image
                        AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconSize: Dimentions.height45 + Dimentions.height30,
                            iconColor: Colors.white,
                            size: Dimentions.height15 * 10),
                        SizedBox(
                          height: Dimentions.height30,
                        ),
                        // User Info
                        Expanded(
                          child: ListView.builder(
                              itemCount: infoData.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (index == 4) {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        print('index == 4');
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .removeCartHistory();
                                        navigateAndReplace(
                                            context, SplashScreen());
                                      } else {
                                        show_custom_snakbar('You Logged Out',
                                            color: Colors.red);
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: Dimentions.height20),
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                            icon: infoData[index]['icon'],
                                            backgroundColor: infoData[index]
                                                ['color'],
                                            iconSize:
                                                Dimentions.height10 * 5 / 2,
                                            iconColor: Colors.white,
                                            size: Dimentions.height10 * 5),
                                        bigText: BigText(
                                          // text: infoData[index]['text'],
                                          text: userModelInfo[index],
                                        )),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ))
                : Center(child: CircularProgressIndicator()))
            : Container(
                child: Center(
                    child: InkWell(
                        onTap: () {
                          navigateAndReplace(context, SignInPage());
                        },
                        child: Text('You Must Logged In'))),
              );
      }),
    );
  }
}
