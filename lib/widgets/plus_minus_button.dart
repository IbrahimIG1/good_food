import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/controller/popular_product_controller.dart';
import 'package:food_delivery_app/data/model/card_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

Widget plusMinusButton(
        {required String quantity,
        required Function plus,
        required Function minus}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
            onTap: () {
              minus();
            },
            child: Icon(Icons.remove, color: AppColors.signColor)),
        SizedBox(width: Dimentions.width10 / 2),
        BigText(text: quantity),
        SizedBox(width: Dimentions.width10 / 2),
        InkWell(
            onTap: () {
              plus();
            },
            child: Icon(Icons.add, color: AppColors.signColor)),
      ],
    );
