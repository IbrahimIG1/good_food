import 'package:flutter/material.dart';


class FlexibleImageSpace extends StatelessWidget {
  const FlexibleImageSpace({super.key, required this.image});
final String image;
  @override
  Widget build(BuildContext context) {
    return Image.network(image,
        fit: BoxFit.cover, width: double.infinity);
  }
}
