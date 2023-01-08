import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';

class NavBarContainer extends StatelessWidget {
  const NavBarContainer({super.key, required this.widget});
final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Container(height: Dimentions.bottomHeightBar,
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimentions.radius20 * 2),
              topRight: Radius.circular(Dimentions.radius20 * 2),
            )),
            child: widget,
            );
  }
}