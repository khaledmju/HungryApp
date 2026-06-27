import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/cart/data/cart_model.dart';
import 'package:hungry/features/cart/data/cart_repo.dart';
import 'package:hungry/features/product/data/product_details_repo.dart';
import 'package:hungry/features/product/data/toppings_model.dart';
import 'package:hungry/features/product/widgets/spicy_slider.dart';
import 'package:hungry/features/product/widgets/topping_card.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_snackBar.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.image,
    required this.productId,
  });

  final String image;

  final int productId;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double sliderValue = 0.1;

  ProductDetailsRepo productDetailsRepo = ProductDetailsRepo();
  CartRepo cartRepo = CartRepo();

  List<ToppingsModel>? toppingsList = [];
  List<ToppingsModel>? sideOptionsList = [];

  List<int> emptyToppingsList = [];
  List<int> emptyOptionsList = [];

  bool isLoading = false;

  bool isLoadingToppings = true;
  bool isLoadingSideOption = true;

  Future<void> getToppings() async {
    try {
      final productToppings = await productDetailsRepo.getToppings();

      setState(() {
        toppingsList = productToppings;
        isLoadingToppings = false;
      });
    } catch (e) {
      setState(() {
        isLoadingToppings = false;
      });
      String msg = "Error in Getting Toppings";
      if (e is ApiError) {
        msg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(msg));
    }
  }

  Future<void> getSideOptions() async {
    try {
      final sideOptions = await productDetailsRepo.getSideOptions();

      setState(() {
        sideOptionsList = sideOptions;
        isLoadingSideOption = false;
      });
    } catch (e) {
      setState(() {
        isLoadingSideOption = false;
      });
      String msg = "Error in Getting Toppings";
      if (e is ApiError) {
        msg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(msg));
    }
  }

  @override
  void initState() {
    super.initState();
    getToppings();
    getSideOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        decoration: const BoxDecoration(
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
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

            isLoading
                ? CupertinoActivityIndicator(color: AppColors.primary)
                : CustomButton(
                    text: "Add To Cart",
                    onTap: () async {
                      try {
                        setState(() => isLoading = true);
                        final cart = CartModel(
                          productId: widget.productId,
                          quantity: 1,
                          spicy: sliderValue,
                          sideOptions: emptyOptionsList,
                          toppings: emptyToppingsList,
                        );

                        await cartRepo.addToCart(
                          CartRequestModel(items: [cart]),
                        );
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(customSnackBar("Added To Cart"));
                        setState(() => isLoading = false);
                      } catch (e) {
                        setState(() => isLoading = false);
                        String msg = "error in details";

                        if (e is ApiError) {
                          setState(() {
                            msg = e.message;
                          });
                        }

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(customSnackBar(msg));
                      }
                    },
                  ),
          ],
        ),
      ),
      appBar: AppBar(scrolledUnderElevation: 0, backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                image: widget.image,
                onChanged: (value) => setState(() => sliderValue = value),
                sliderValue: sliderValue,
              ),
              const Gap(30),
              const CustomText(text: "Toppings", textSize: 20),
              const Gap(10),

              isLoadingToppings
                  ? CupertinoActivityIndicator(
                      color: AppColors.primary,
                      radius: 15,
                    )
                  : SingleChildScrollView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(toppingsList!.length, (index) {
                          final topping = toppingsList![index];
                          final isSelectedTopping = emptyToppingsList.contains(
                            topping.id,
                          );
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ToppingCard(
                              imageUrl: topping.image,
                              title: topping.name,
                              onAdd: () {
                                setState(() {
                                  if (!isSelectedTopping) {
                                    emptyToppingsList.add(topping.id);
                                  } else {
                                    emptyToppingsList.remove(topping.id);
                                  }
                                });
                              },
                              color: isSelectedTopping
                                  ? Colors.green.withOpacity(0.2)
                                  : AppColors.primary.withOpacity(0.1),
                            ),
                          );
                        }),
                      ),
                    ),

              const Gap(20),

              const CustomText(text: "Side options", textSize: 20),
              const Gap(10),

              isLoadingSideOption
                  ? CupertinoActivityIndicator(
                      color: AppColors.primary,
                      radius: 15,
                    )
                  : SingleChildScrollView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(sideOptionsList!.length, (
                          index,
                        ) {
                          final sideOption = sideOptionsList![index];
                          final isSelectedOption = emptyOptionsList.contains(
                            sideOption.id,
                          );
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ToppingCard(
                              imageUrl: sideOption.image,
                              title: sideOption.name,
                              onAdd: () {
                                setState(() {
                                  if (!isSelectedOption) {
                                    emptyOptionsList.add(sideOption.id);
                                  } else {
                                    emptyOptionsList.remove(sideOption.id);
                                  }
                                });
                              },
                              color: isSelectedOption
                                  ? Colors.green.withOpacity(0.2)
                                  : AppColors.primary.withOpacity(0.1),
                            ),
                          );
                        }),
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
