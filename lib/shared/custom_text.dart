import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textWeight, this.textMaxLine,
  });

  final String text;

  final Color? textColor;

  final double? textSize;

  final FontWeight? textWeight;
  final int? textMaxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: textMaxLine,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontWeight: textWeight,
      ),
    );
  }
}
