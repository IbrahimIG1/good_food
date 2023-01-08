import 'package:flutter/material.dart';
import '../../../utils/dimentions.dart';
import '../../../widgets/big_text.dart';

class BottomPreferredSize extends StatelessWidget {
  const BottomPreferredSize({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimentions.radius15),
                topRight: Radius.circular(Dimentions.radius15))),
        width: double.infinity,
        child: Center(
            child: BigText(
          text: 'Chinese Side',
          size: Dimentions.font26,
        )));
  }
}
