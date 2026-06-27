import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    this.onAdd,
    this.onMin,
    this.onRemove,
    required this.number,
  });

  final String image, title, desc;

  final Function()? onAdd;
  final Function()? onMin;
  final Function()? onRemove;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: image,
                  width: 100,
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/test/test.png", width: 100),
                ),

                // Image.asset(image, width: 100),
                CustomText(text: title, textWeight: FontWeight.bold),
                CustomText(text: "Spicy : $desc"),
              ],
            ),

            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onAdd,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                    const Gap(20),
                    CustomText(
                      text: number,
                      textWeight: FontWeight.w400,
                      textSize: 20,
                    ),
                    const Gap(20),

                    GestureDetector(
                      onTap: onMin,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: const Icon(Icons.remove, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const Gap(26),
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 15,
                    ),
                    // height: 45,
                    // width: 130,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const CustomText(
                      text: "remove",
                      textColor: Colors.white,
                      textSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
