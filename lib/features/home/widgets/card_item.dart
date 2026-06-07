import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../shared/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/test/test.png", width: 180),
            const Gap(10),
            const CustomText(
              text: "Cheeseburger",
              textWeight: FontWeight.bold,
              textSize: 16,
            ),
            const CustomText(
              text: "Wendy's Burger",
              textSize: 16,
              textWeight: FontWeight.w400,
            ),
            const CustomText(text: "⭐ 4.9"),
          ],
        ),
      ),
    );
  }
}
