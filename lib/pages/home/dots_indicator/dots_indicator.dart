import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class MyDotsIndicator extends StatelessWidget {
  const MyDotsIndicator({super.key, required this.currPageValue,required this.dotsCount});
  final currPageValue;
  final int dotsCount;
  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: dotsCount,
      position: currPageValue,
      decorator: DotsDecorator(
        // activeColor: AppColors.mainColor,
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
