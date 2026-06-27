import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../core/constants/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.height,
    this.color,
    this.gap,
    this.widget,
    this.textColor,
  });

  final String text;

  final Function()? onTap;

  final double? width;
  final double? height;
  final double? gap;

  final Color? color;
  final Color? textColor;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 50,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: text,
              textWeight: FontWeight.w600,
              textSize: 18,
              textColor: textColor ?? Colors.white,
            ),
            Gap(gap ?? 0.0),
            widget ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
