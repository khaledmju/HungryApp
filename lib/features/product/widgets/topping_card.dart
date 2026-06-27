import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/shared/custom_text.dart';

class ToppingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onAdd;
  final Color color;

  const ToppingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onAdd,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              color: color,
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 80,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const Gap(10),
                  CustomText(
                    text: title,
                    textColor: Colors.black,
                    textSize: 14,
                    textWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
          const Gap(5),
        ],
      ),
    );
  }
}
