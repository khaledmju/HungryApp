import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/home/data/product_model.dart';
import '../../../shared/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (productModel.image == "")
                ? Image.asset("assets/test/test.png")
                :
            CachedNetworkImage(
                    imageUrl: productModel.image,
                    width: 180,
                    fit: BoxFit.cover,
                  ),

            const Gap(10),
            CustomText(
              text: productModel.name,
              textWeight: FontWeight.bold,
              textSize: 16,
            ),
            CustomText(
              text: productModel.desc,
              textSize: 16,
              textWeight: FontWeight.w400,
              textMaxLine: 4,
            ),
            CustomText(text: "⭐ ${productModel.rate}"),
          ],
        ),
      ),
    );
  }
}
