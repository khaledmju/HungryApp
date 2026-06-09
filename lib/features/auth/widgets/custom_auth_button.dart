import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.textColor,
    this.textSize,
    this.isBorder,
  });

  final String text;

  final void Function()? onTap;

  final Color? color;
  final Color? textColor;
  final double? textSize;
  final bool? isBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: isBorder == true ? Border.all(color: Colors.white) : null,
        ),
        child: Center(
          child: CustomText(
            text: text,
            textSize: textSize ?? 15,
            textColor: textColor ?? AppColors.primary,
            textWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
