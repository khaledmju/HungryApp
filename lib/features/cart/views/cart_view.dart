import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/cart/widgets/cart_item.dart';

import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final int itemCount = 20;

  late List<int> quantities;

  @override
  void initState() {
    super.initState();

    quantities = List.generate(itemCount, (_) => 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 50, bottom: 120),
          itemCount: itemCount,
          itemBuilder: (context, index) => CartItem(
            image: "assets/test/test.png",
            title: "Hamburger",
            desc: "Veggie Burger",
            number: quantities[index].toString(),
            onAdd: () {
              setState(() {
                quantities[index]++;
              });
            },
            onMin: () {
              setState(() {
                if (quantities[index] > 1) {
                  quantities[index]--;
                }
              });
            },
            onRemove: () {},
          ),
        ),
      ),

      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
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

            CustomButton(text: "CheckOut", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
