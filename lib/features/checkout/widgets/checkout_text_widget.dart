import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../shared/custom_text.dart';

class CheckoutTextWidget extends StatelessWidget {
  const CheckoutTextWidget({
    super.key,
    required this.order,
    required this.taxes,
    required this.deliveryFees,
    required this.total,
    required this.deliveryTime,
  });

  final String order, taxes, deliveryFees, total, deliveryTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        checkOutText("order", order, false, false, false),
        Gap(10),
        checkOutText("Taxes", taxes, false, false, false),
        Gap(10),
        checkOutText("Delivery fees", deliveryFees, false, false, false),
        Gap(10),
        Divider(),
        Gap(20),
        checkOutText("Total:", total, true, false, false),
        Gap(20),
        checkOutText(
          "Estimated delivery time:",
          deliveryTime,
          true,
          true,
          true,
        ),
      ],
    );
  }
}

Widget checkOutText(title, price, isBold, isSmall, isTime) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: title,
        textColor: isBold ? Colors.black : Colors.grey.shade500,
        textSize: isSmall ? 16 : 18,
        textWeight: isBold ? FontWeight.bold : FontWeight.w400,
      ),
      CustomText(
        text: isTime ? price : "$price \$",
        textColor: isBold ? Colors.black : Colors.grey.shade500,
        textSize: isSmall ? 16 : 18,
        textWeight: isBold ? FontWeight.bold : FontWeight.w400,
      ),
    ],
  );
}
