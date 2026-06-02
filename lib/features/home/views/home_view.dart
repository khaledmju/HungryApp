import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/home/widgets/card_item.dart';
import 'package:hungry/features/home/widgets/food_category.dart';
import 'package:hungry/features/home/widgets/search_field.dart';
import 'package:hungry/features/home/widgets/user_header.dart';
import 'package:hungry/shared/custom_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ["All", "Combos", "Sliders", "Classic"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Gap(70),
                UserHeader(),
                Gap(20),
                SearchField(),
                Gap(20),
                FoodCategory(category: category, selectedIndex: selectedIndex),
                Gap(20),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return CardItem();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
