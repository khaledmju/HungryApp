import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/product/widgets/spicy_slider.dart';
import 'package:hungry/features/product/widgets/topping_card.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 15, offset: Offset(0, 0)),
          ],
        ),
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Total",
                  textSize: 16,
                  textWeight: FontWeight.w600,
                ),
                CustomText(
                  text: "\$18.19",
                  textSize: 25,
                  textWeight: FontWeight.w400,
                ),
              ],
            ),

            CustomButton(text: "Add To Cart", onTap: () {}),
          ],
        ),
      ),
      appBar: AppBar(scrolledUnderElevation: 0, backgroundColor: Colors.white),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                onChanged: (value) => setState(() => sliderValue = value),
                sliderValue: sliderValue,
              ),
              Gap(50),
              CustomText(text: "Toppings", textSize: 20),
              Gap(50),

              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ToppingCard(
                        imageUrl: "assets/test/tomato.png",
                        title: "Tomato",
                        onAdd: () {},
                        color: AppColors.toppingColor,
                      ),
                    ),
                  ),
                ),
              ),

              Gap(20),

              CustomText(text: "Side options", textSize: 20),
              Gap(50),

              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ToppingCard(
                        imageUrl: "assets/test/tomato.png",
                        title: "Tomato",
                        onAdd: () {},
                        color: AppColors.toppingColor,
                      ),
                    ),
                  ),
                ),
              ),
              // Gap(50),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         CustomText(
              //           text: "Total",
              //           textSize: 18,
              //           textWeight: FontWeight.w600,
              //         ),
              //         CustomText(
              //           text: "\$18.19",
              //           textSize: 30,
              //           textWeight: FontWeight.w400,
              //         ),
              //       ],
              //     ),
              //
              //     CustomButton(text: "Add To Cart", onTap: () {}),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
