import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';

class AppTextFeild extends StatelessWidget {
  final TextEditingController emailController;
  final String hinttext;
  final IconData icon;
  bool obscure; // for password
  AppTextFeild({
    super.key,
    required this.emailController,
    required this.hinttext,
    required this.icon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimentions.height20, right: Dimentions.height20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimentions.radius15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 3,
              spreadRadius: 1,
              offset: Offset(1, 1),
            )
          ]),
      child: TextField(
        obscureText: obscure ? true : false,
        controller: emailController,
        decoration: InputDecoration(
          // hint text
          hintText: hinttext,
          // prefix Icon
          prefixIcon: Icon(
            icon,
            color: AppColors.mainColor,
          ),
          // focused Border
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimentions.radius15),
              borderSide: BorderSide(width: 1, color: Colors.white)),
          // enabled order
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimentions.radius15),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}
