import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class SpicySlider extends StatefulWidget {
  const SpicySlider({
    super.key,
    required this.sliderValue,
    required this.onChanged,
    required this.image,
  });

  final double sliderValue;
  final String image;
  final void Function(double) onChanged;

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Image.asset("assets/details/details.png", height: 250),
        CachedNetworkImage(imageUrl: widget.image,height: 200,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const CustomText(
            //   text:
            //       "Customize Your Burger\n to Your Tastes.\n Ultimate Experience",
            // ),
            // // const Gap(20),
            const CustomText(
              text: "Spicy",
              textWeight: FontWeight.bold,
              textSize: 15,
            ),
            const Gap(5),
            Slider(
              padding: EdgeInsets.zero,
              inactiveColor: const Color(0xff7d7d7d47),
              activeColor: AppColors.primary,
              min: 0,
              max: 1,
              value: widget.sliderValue,
              onChanged: widget.onChanged,
            ),
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "🥶"),
                // Gap(150),
                CustomText(text: "🌶"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
