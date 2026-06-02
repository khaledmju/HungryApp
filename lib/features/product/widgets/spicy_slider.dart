import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class SpicySlider extends StatefulWidget {
  const SpicySlider({
    super.key,
    required this.sliderValue,
    required this.onChanged,
  });

  final double sliderValue;
  final void Function(double) onChanged;

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/details/details.png", height: 250),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text:
                  "Customize Your Burger\n to Your Tastes.\n Ultimate Experience",
            ),
            Gap(20),
            CustomText(
              text: "Spicy",
              textWeight: FontWeight.bold,
              textSize: 15,
            ),
            Gap(5),
            Slider(
              padding: EdgeInsets.zero,
              inactiveColor: Color(0xff7D7D7D47),
              activeColor: AppColors.primary,
              min: 0,
              max: 1,
              value: widget.sliderValue,
              onChanged: widget.onChanged,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomText(text: "🥶"),
                Gap(150),
                CustomText(text: "🌶"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
