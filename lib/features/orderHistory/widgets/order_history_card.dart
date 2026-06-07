import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({
    super.key,
    required this.image,
    required this.text,
    required this.qty,
    required this.price,
    this.onTap,
  });

  final String image, text, qty, price;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(image, width: 100),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: text, textWeight: FontWeight.bold),
                    CustomText(text: "Qty : $qty", textSize: 16),
                    CustomText(text: "Price : $price\$", textSize: 16),
                  ],
                ),
              ],
            ),

            const Gap(20),

            CustomButton(
              text: "Order Again",
              width: double.infinity,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
