import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/cart/data/cart_model.dart';
import 'package:hungry/features/cart/data/cart_repo.dart';
import 'package:hungry/features/cart/widgets/cart_item.dart';
import 'package:hungry/features/home/views/home_view.dart';
import 'package:hungry/shared/custom_snackBar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';
import '../../checkout/views/checkout_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // final int itemCount = 9;

  late List<int> quantities;

  CartRepo cartRepo = CartRepo();

  bool isLoading = true;

  ViewCartModel? viewCartModel;

  bool isLoadingDelete = false;

  Future<void> getCart() async {
    try {
      if (!mounted) return;

      final response = await cartRepo.getCart();

      final itemCount = response?.cartData.items.length ?? 0;
      setState(() {
        isLoading = false;
        quantities = List.generate(itemCount, (_) => 1);
        viewCartModel = response;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      String msg = "error in cart";

      if (e is ApiError) {
        setState(() {
          msg = e.message;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(msg));
    }
  }

  Future<void> deleteItem(int itemId) async {
    try {
      setState(() {
        isLoadingDelete = true;
      });
      final response = await cartRepo.deleteItem(itemId);

      await getCart();
      setState(() {
        isLoadingDelete = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar(response["message"]));


    } catch (e) {
      setState(() {
        isLoadingDelete = false;
      });
      String msg = "error in cart";
      if (e is ApiError) {
        setState(() {
          msg = e.message;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(msg));
    }
  }

  @override
  void initState() {
    super.initState();

    getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const SizedBox.shrink(),
          centerTitle: true,
          title: const CustomText(
            text: 'My Cart',
            textColor: Colors.black87,
            textWeight: FontWeight.w600,
            textSize: 20,
          ),
        ),
        body: isLoadingDelete == true
            ? Center(
                child: CupertinoActivityIndicator(color: AppColors.primary),
              )
            : RefreshIndicator(
                onRefresh: () async => getCart(),
                child: Stack(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.only(bottom: 120),
                      itemCount: viewCartModel?.cartData.items.length ?? 10,
                      itemBuilder: (context, index) {
                        final item = viewCartModel?.cartData.items[index];
                        return CartItem(
                          image: item?.image ?? "",
                          title: item?.name ?? "",
                          desc: item?.spicy.toString() ?? "",
                          number: item?.quantity.toString() ?? "1",
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
                          onRemove: () {
                            deleteItem(item!.itemId);
                          },
                        );
                      },
                    ),
                    Positioned(
                      right: -10,
                      left: -10,
                      bottom: -20,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary.withOpacity(0.8),
                              AppColors.primary.withOpacity(0.8),
                              AppColors.primary,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            const Gap(8),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CheckoutView(
                                    totalPrice:
                                        viewCartModel?.cartData.totalPrice ??
                                        "0",
                                    checkoutModel: viewCartModel!.cartData,
                                  ),
                                ),
                              ),
                              child: CustomButton(
                                text: 'Checkout',
                                color: Colors.white,
                                textColor: Colors.black,
                                width: double.infinity,

                                gap: 80,
                                widget: CustomText(
                                  text:
                                      '${viewCartModel?.cartData.totalPrice}\$' ??
                                      "0.0",
                                  textSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
