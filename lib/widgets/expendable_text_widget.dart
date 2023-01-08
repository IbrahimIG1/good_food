import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class ExpendableTextWidget extends StatefulWidget {
  const ExpendableTextWidget({super.key, required this.text});
  final String text;
  @override
  State<ExpendableTextWidget> createState() => _ExpendableTextWidgetState();
}

class _ExpendableTextWidgetState extends State<ExpendableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimentions.screenHeight / 8.0364;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              size: Dimentions.font15,
              color: AppColors.paraColor)
          : Column(children: [
              SmallText(
                text:
                    hiddenText ? (firstHalf + '...') : (firstHalf + secondHalf),
                height: 1.7,
                size: Dimentions.font15,
                color: AppColors.paraColor,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    hiddenText = !hiddenText;
                    
                  });
                },
                child: Row(
                  children: [
                    SmallText(text: 'Show More', color: AppColors.mainColor),
                    Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor),
                  ],
                ),
              )
            ]),
    );
  }
}
