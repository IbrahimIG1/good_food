import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimentions.dart';

class NavButton extends StatelessWidget {
  const NavButton({super.key, required this.widget, required this.buttonColor});
  final Widget widget;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimentions.height15),
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(Dimentions.radius20)),
      child: widget,
    );
  }
}
