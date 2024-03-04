import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/validation_custom_snakbar.dart';
import 'package:food_delivery_app/data/controller/auth_controller.dart';
import 'package:food_delivery_app/data/model/signup_model.dart';
import 'package:food_delivery_app/pages/auth/sign_in.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/app_text_feild.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // controllers
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    // Account Data UI Information
    List<Map> _infoData = [
      {
        'icon': Icons.email,
        'text': 'Email',
        'controller': emailController,
        'obscure': false
      },
      {
        'icon': Icons.password,
        'text': 'Password',
        'controller': passwordController,
        'obscure': true
      },
      {
        'icon': Icons.person,
        'text': 'Name',
        'controller': nameController,
        'obscure': false
      },
      {
        'icon': Icons.phone,
        'text': 'Phone',
        'controller': phoneController,
        'obscure': false
      },
    ];
    List<String> singUpImages = [
      'f.png',
      'g.png',
      't.png',
    ];
    void _registration(AuthController authController) {
      // AuthController authController = Get.find<AuthController>();
      // convert controllers to string
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      // validate controller data
      if (name.isEmpty) {
        show_custom_snakbar('type in your name', title: 'Name');
      } else if (phone.isEmpty) {
        show_custom_snakbar('type in your phone', title: 'phone');
      } else if (email.isEmpty) {
        show_custom_snakbar('type in your email', title: 'email');
      } else if (!GetUtils.isEmail(email)) {
        show_custom_snakbar('type vaild email', title: 'email');
      } else if (password.isEmpty) {
        show_custom_snakbar('type in your password', title: 'password');
      } else if (password.length < 6) {
        show_custom_snakbar('your password musn\'t less than 6',
            title: 'password');
      } else {
        show_custom_snakbar('Will Done',
            title: 'Sign up Success', color: Colors.green);
        // put data in model
        SignUpModel signUpModel = SignUpModel(
            name: name, phone: phone, password: password, email: email);
        authController.registration(signUpModel).then((status) {
          if (status.isSuccess) {
            // Get.to(SignInPage());
          } else {
            show_custom_snakbar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimentions.screenHeight * 0.05,
                    ),
                    // Logo
                    Container(
                      height: Dimentions.screenHeight * 0.25,
                      child: Center(
                        child: CircleAvatar(
                          radius: Dimentions.radius70,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('assets/image/logo part 1.png'),
                        ),
                      ),
                    ),
                    // information Feilds
                    Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: Dimentions.screenHeight / 2.55,
                        child: Wrap(
                          children: List.generate(
                              _infoData.length,
                              (index) => Padding(
                                    padding: EdgeInsets.only(
                                        bottom: Dimentions.height20),
                                    child: AppTextFeild(
                                        emailController: _infoData[index]
                                            ['controller'],
                                        hinttext: _infoData[index]['text'],
                                        obscure: _infoData[index]['obscure'],
                                        icon: _infoData[index]['icon']),
                                  )),
                        )),

                    // Sign Up Button
                    InkWell(
                      onTap: () {
                        _registration(_authController);
                        // DioHelper.postData(
                        //     path: AppConstants.REGISTRATION_URI,
                        //     data: {
                        //       'email': 'email@email.com',
                        //       'password': 'password',
                        //       'phone': 'phone',
                        //       'f_name': 'name',
                        //     }).then((value) => print('register Done'));
                      },
                      child: Container(
                        width: Dimentions.screenWidth / 2,
                        height: Dimentions.screenHeight / 13,
                        child: Center(
                          child: BigText(
                            size: Dimentions.font20 + Dimentions.font15 / 2,
                            text: 'sign up',
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius30)),
                      ),
                    ),
                    SizedBox(
                      height: Dimentions.height10,
                    ),
                    // Have An Account? Button
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: BigText(
                        text: 'have an account ?',
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: Dimentions.height30,
                    ),

                    BigText(
                      text: 'sign up using one of this following methods',
                      size: 15,
                      color: Colors.grey,
                    ),
                    Wrap(
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimentions.height10,
                                    horizontal: Dimentions.height10),
                                child: CircleAvatar(
                                  radius: Dimentions.radius30,
                                  backgroundImage: AssetImage(
                                      'assets/image/' + singUpImages[index]),
                                ),
                              )),
                    )
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator());
      }),
    );
  }
}
