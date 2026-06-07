import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/views/profile_view.dart';
import 'package:hungry/features/cart/views/cart_view.dart';
import 'package:hungry/features/home/views/home_view.dart';
import 'package:hungry/features/orderHistory/views/order_history_view.dart';

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

    screens = [const HomeView(), const CartView(), const OrderHistoryView(), const ProfileView()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: screens,
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: selectedScreen,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() => selectedScreen = index);

            pageController.jumpToPage(selectedScreen);
          },

          items: [
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart),
              label: "Cart",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.local_restaurant_sharp),
              label: "Order History",
            ),
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: "profile",
            ),
          ],
        ),
      ),
    );
  }
}
