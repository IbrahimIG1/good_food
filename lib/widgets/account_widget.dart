import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({super.key, required this.appIcon, required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimentions.width20,
          top: Dimentions.width10,
          bottom: Dimentions.width10),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimentions.width20,
          ),
          bigText,
        ],
      ),
      // Decoration
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 1)
      ]),
    );
  }
}
