import 'package:flutter/material.dart';
import 'package:hungry/features/orderHistory/widgets/order_history_card.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),

        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) => OrderHistoryCard(
            image: "assets/test/test.png",
            text: "Hamburger",
            qty: "X3",
            price: "20",
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
