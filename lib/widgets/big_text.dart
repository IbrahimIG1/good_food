import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimentions.dart';

class BigText extends StatelessWidget {
  BigText(
      {super.key,
      required this.text,
      this.color = const Color(0xFF332d2b),
      this.textOverflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.w400,
      this.size = 0});
  final String text;
  FontWeight fontWeight;
  Color color;
  TextOverflow textOverflow;
  double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style: TextStyle(
          fontSize: size == 0 ? Dimentions.font20 : size,
          color: color,
          fontWeight: fontWeight,
          fontFamily: 'Roboto',
          overflow: textOverflow),
    );
  }
}
