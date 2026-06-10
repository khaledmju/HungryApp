import 'dart:ui'; // Required for ImageFilter.blur
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: screens,
          ),

          // Floating Blurred Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              // Controls the floating gap on the bottom, left, and right sides
              padding: const EdgeInsets.only(
                bottom: 20.0,
                left: 24.0,
                right: 24.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  40,
                ), // Gives it the pill shape
                child: BackdropFilter(
                  // This creates the glassmorphism/blur effect
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    // Light, translucent white color acting as the glass overlay
                    color: Colors.white.withOpacity(0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(CupertinoIcons.home, "Home", 0),
                        _buildNavItem(CupertinoIcons.cart, "Cart", 1),
                        _buildNavItem(
                          Icons.table_restaurant_outlined,
                          "History",
                          2,
                        ),
                        _buildNavItem(
                          CupertinoIcons.person_circle,
                          "Profile",
                          3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = selectedScreen == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedScreen = index);
        pageController.jumpToPage(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // The dark oval background highlight for the active item
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.black.withOpacity(0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.black87 : Colors.black45,
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? Colors.black87 : Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
