import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimentions.dart';

import 'package:food_delivery_app/widgets/small_text.dart';

class IconAndTextRow extends StatelessWidget {
  const IconAndTextRow({super.key, required this.text,  required this.iconColor, required this.icon});
final String text;
final Color iconColor;
final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: Dimentions.iconSize24,
          color: iconColor,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(text:text,),
      ],
    );
  }
}
