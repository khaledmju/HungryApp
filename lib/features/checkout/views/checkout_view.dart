import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/cart/data/cart_model.dart';
import 'package:hungry/features/checkout/data/checkout_model.dart';
import 'package:hungry/features/checkout/data/checkout_repo.dart';
import 'package:hungry/features/checkout/widgets/checkout_text_widget.dart';
import 'package:hungry/root.dart';
import 'package:hungry/shared/custom_snackBar.dart';
import 'package:hungry/shared/custom_text.dart';

import '../../../shared/custom_button.dart';
import '../widgets/success_dialog.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    required this.totalPrice,
    required this.checkoutModel,
  });

  final String totalPrice;
  final CartData checkoutModel;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = "cash";
  bool isChecked = false;
  bool isLoading = false;
  CheckoutRepo checkoutRepo = CheckoutRepo();

  double taxes = 0.3;

  double deliveryFee = 1.5;

  String totalPriceOrder() {
    final double sum = double.parse(widget.totalPrice) + taxes + deliveryFee;
    return sum.toString();
  }

  Future<void> checkoutOrder(CheckoutRequestModel checkoutModel) async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await checkoutRepo.checkoutData(checkoutModel);

      setState(() {
        isLoading = false;
      });

      showSuccessDialog(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar(response["message"]));

      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Root()),
      );
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      String msg = "error in checkout";

      if (e is ApiError) {
        setState(() {
          msg = e.message;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(msg));
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(color: AppColors.primary),
            ),
          )
        : Scaffold(
            bottomSheet: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Total",
                        textSize: 16,
                        textWeight: FontWeight.w600,
                      ),
                      CustomText(
                        // text: "\$ ${widget.totalPrice}",
                        text: "\$${totalPriceOrder()} ",
                        textSize: 25,
                        textWeight: FontWeight.w400,
                      ),
                    ],
                  ),

                  CustomButton(
                    text: "Pay Now",
                    onTap: () {
                      final checkoutRequest = CheckoutRequestModel(
                        items: widget.checkoutModel.items
                            .map(
                              (item) => CheckoutModel(
                                productId: item.productId,
                                quantity: item.quantity,
                                spicy: item.spicy,
                                toppings: item.toppings
                                    .map((t) => t.id)
                                    .toList(),
                                sideOptions: item.sideOptions
                                    .map((s) => s.id)
                                    .toList(),
                              ),
                            )
                            .toList(),
                      );
                      checkoutOrder(checkoutRequest);
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Order Summary",
                      textSize: 20,
                      textWeight: FontWeight.bold,
                    ),
                    const Gap(10),
                    CheckoutTextWidget(
                      order: widget.totalPrice,
                      taxes: "0.3",
                      deliveryFees: "1.5",
                      total: totalPriceOrder() ?? "",
                      deliveryTime: "15 - 30 mins",
                    ),
                    const Gap(80),
                    const CustomText(
                      text: "Payment methods",
                      textSize: 20,
                      textWeight: FontWeight.bold,
                    ),
                    const Gap(20),
                    ListTile(
                      onTap: () {
                        setState(() {
                          selectedMethod = "cash";
                        });
                      },
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 16,
                        vertical: 15,
                      ),
                      tileColor: AppColors.toppingColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      leading: Image.asset("assets/icons/cash.png"),
                      title: const CustomText(
                        text: "Cash on Delivery",
                        textSize: 20,
                        textColor: Colors.white,
                      ),
                      trailing: RadioGroup<String>(
                        groupValue: selectedMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedMethod = value!;
                          });
                        },
                        child: const Radio(
                          activeColor: Colors.white,
                          value: "cash",
                        ),
                      ),
                    ),

                    const Gap(10),
                    ListTile(
                      onTap: () {
                        setState(() {
                          selectedMethod = "visa";
                        });
                      },
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      tileColor: AppColors.grayColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      leading: Image.asset("assets/icons/visa.png", width: 50),
                      title: const CustomText(
                        text: "Debit card",
                        textSize: 20,
                        textColor: Colors.black,
                        textWeight: FontWeight.w500,
                      ),
                      subtitle: CustomText(
                        text: "3566 **** **** 0505",
                        textColor: Colors.grey.shade500,
                      ),
                      trailing: RadioGroup<String>(
                        groupValue: selectedMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedMethod = value!;
                          });
                        },
                        child: Radio(
                          activeColor: AppColors.primary,
                          value: "visa",
                        ),
                      ),
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.redColor,
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const CustomText(
                          text: "Save card details for future payments",
                          textSize: 16,
                          textWeight: FontWeight.w600,
                          textColor: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
