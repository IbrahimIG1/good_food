import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/validation_custom_snakbar.dart';
import 'package:food_delivery_app/data/controller/dio_helper.dart';
import 'package:food_delivery_app/data/model/sign_in_model.dart';
import 'package:food_delivery_app/data/model/signup_model.dart';
import 'package:food_delivery_app/data/model/user_model.dart';
import 'package:food_delivery_app/pages/auth/sign_up.dart';
import 'package:food_delivery_app/pages/cart_icon_page.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/shared_packages/navigators.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/app_text_feild.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../data/controller/auth_controller.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // controllers
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

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
      }
    ];

    void _login(AuthController authController) {
      // AuthController authController = Get.find<AuthController>();
      // convert controllers to string

      String password = passwordController.text.trim();

      String email = emailController.text.trim();
      // // validate controller data
      // if (email.isEmpty) {
      //   show_custom_snakbar('type in your email', title: 'email');
      // } else if (!GetUtils.isEmail(email)) {
      //   show_custom_snakbar('type vaild email', title: 'email');
      // } else if (password.isEmpty) {
      //   show_custom_snakbar('type in your password', title: 'password');
      // } else if (password.length < 6) {
      //   show_custom_snakbar('your password musn\'t less than 6',
      //       title: 'password');
      // } else {

      // put data in model
      SignInModel signInModel = SignInModel(
          email: 'yo@gmail.com', phone: "12345689", password: '123456789');
      authController
          .login(email: email, password: password, phone: '13232684684')
          .then((status) {
        if (status.isSuccess) {
          show_custom_snakbar('Will Done',
              title: 'Sign up Success', color: Colors.green);
          navigateAndReplace(context, MainFoodPage());
          print('Login Sucess');
        } else {
          show_custom_snakbar(status.message);
        }
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimentions.screenHeight * 0.05,
                        ),
                        // Logo
                        Container(
                          height: Dimentions.screenHeight * 0.25,
                          child: Center(
                            child: CircleAvatar(
                              radius: Dimentions.radius70 + Dimentions.radius30,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage('assets/image/logo part 1.png'),
                            ),
                          ),
                        ),
                        // txt : Hello
                        Padding(
                          padding: EdgeInsets.only(left: Dimentions.height20),
                          child: BigText(
                            text: 'Hello',
                            size: Dimentions.font26 * 2.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: Dimentions.height20,
                        ),
                        // txt : sign into your account
                        Padding(
                          padding: EdgeInsets.only(left: Dimentions.height20),
                          child: BigText(
                            text: 'sign into your account',
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: Dimentions.height30,
                        ),
                        // information Feilds
                        Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: Dimentions.screenHeight / 5,
                            child: Wrap(
                              children: List.generate(
                                  _infoData.length,
                                  (index) => Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Dimentions.height30),
                                        child: AppTextFeild(
                                            emailController: _infoData[index]
                                                ['controller'],
                                            obscure: _infoData[index]
                                                ['obscure'],
                                            hinttext: _infoData[index]['text'],
                                            icon: _infoData[index]['icon']),
                                      )),
                            )),
                        // txt : sign into your account
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: Dimentions.height20),
                            child: BigText(
                              text: 'sign into your account',
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimentions.height30,
                        ),
                        //  Button : Sign In
                        Center(
                          child: InkWell(
                            onTap: () {
                              _login(authController);
                              // DioHelper.postData(
                              //     path: AppConstants.LOGIN_URI,
                              //     data: {
                              //       "email": "yo@gmail.com",
                              //       "password": "123456",
                              //       "phone":"123456789"
                              //     });
                              print('Sign In Click');
                              // print(AppConstants.TOKEN);
                            },
                            child: Container(
                              width: Dimentions.screenWidth / 2,
                              height: Dimentions.screenHeight / 13,
                              child: Center(
                                child: BigText(
                                  size:
                                      Dimentions.font20 + Dimentions.font15 / 2,
                                  text: 'sign in',
                                  color: Colors.white,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimentions.radius30)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimentions.height20,
                        ),
                        // txt : Don\'t have an account? Create
                        Center(
                          child: RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: 'Don\'t have an account? '),
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Get.to(
                                            () => SignUpPage(),
                                            transition: Transition.fade),
                                      text: 'Create',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700)),
                                ],
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Dimentions.font20)),
                          ),
                        )
                      ]),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        }));
  }
}
