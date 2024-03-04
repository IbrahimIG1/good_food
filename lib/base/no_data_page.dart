import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  NoDataPage(
      {super.key,
      required this.text,
      this.imgPath = 'assets/image/empty_cart.png'});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize =
        MediaQuery.of(context).size; // mediaQuerySize abbreviation "اختصار"
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imgPath,
          height: mediaQuerySize.height * .22,
          width: mediaQuerySize.width * .22,
        ),
        SizedBox(
          height: mediaQuerySize.height * .03,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: mediaQuerySize.height * .01753,
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
