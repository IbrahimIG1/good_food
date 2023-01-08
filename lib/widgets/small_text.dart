import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  SmallText(
      {super.key,
      required this.text,
      this.color = const Color(0xFFccc7c5),
      this.size = 12,
      this.height = 1.2,this.maxLines = 20});
  final String text;
  Color color;
  double height;
  double size;
  int maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines:maxLines ,
      style: TextStyle(
          fontSize: size,
          height: height,
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto'),
    );
  }
}
