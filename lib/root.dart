import 'dart:ui'; // Required for ImageFilter.blur
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/features/auth/views/profile_view.dart';
import 'package:hungry/features/cart/views/cart_view.dart';
import 'package:hungry/features/home/views/home_view.dart';
import 'package:hungry/features/orderHistory/views/order_history_view.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:hungry/shared/glass_nav.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController pageController;
  late List<Widget> screens;
  int selectedScreen = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: selectedScreen);
    screens = [
      const HomeView(),
      const CartView(),
      const OrderHistoryView(),
      const ProfileView(),
    ];
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody allows the PageView content to flow completely behind the nav bar area
      extendBody: true,
      body: IndexedStack(index: selectedScreen, children: screens),
      bottomNavigationBar: GlassBottomNavBar(
        currentIndex: selectedScreen,
        onTap: (value) {
          setState(() {
            selectedScreen = value;
          });
        },
        items: [
          BottomNavItemData(
            label: 'Home',
            icon: const Icon(CupertinoIcons.home),
            filledIcon: const Icon(CupertinoIcons.house_fill),
          ),
          BottomNavItemData(
            label: 'Cart',
            icon: const Icon(CupertinoIcons.cart),
            filledIcon: const Badge(
              label: CustomText(text: '1', textSize: 10),
              child: Icon(CupertinoIcons.cart_fill_badge_plus),
            ),
          ),
          BottomNavItemData(
            label: 'History',
            icon: const Icon(Icons.table_bar_outlined),
            filledIcon: const Icon(Icons.table_bar_rounded),
          ),
          BottomNavItemData(
            label: 'Profile',
            icon: const Icon(CupertinoIcons.person_alt_circle),
            filledIcon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
