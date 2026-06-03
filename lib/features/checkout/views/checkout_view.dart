import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/checkout/widgets/checkout_text_widget.dart';
import 'package:hungry/shared/custom_text.dart';

import '../../../shared/custom_button.dart';
import '../widgets/success_dialog.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = "cash";
  bool isChecked = false;

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

            CustomButton(
              text: "Pay Now",
              onTap: () {
                showSuccessDialog(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(scrolledUnderElevation: 0, backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Order Summary",
                textSize: 20,
                textWeight: FontWeight.bold,
              ),
              Gap(10),
              CheckoutTextWidget(
                order: "18.32",
                taxes: "0.3",
                deliveryFees: "1.5",
                total: "100",
                deliveryTime: "15 - 30 mins",
              ),
              Gap(80),
              CustomText(
                text: "Payment methods",
                textSize: 20,
                textWeight: FontWeight.bold,
              ),
              Gap(20),
              ListTile(
                onTap: () {
                  setState(() {
                    selectedMethod = "cash";
                  });
                },
                contentPadding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),
                tileColor: AppColors.toppingColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                leading: Image.asset("assets/icons/cash.png"),
                title: CustomText(
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
                  child: Radio(activeColor: Colors.white, value: "cash"),
                ),
              ),

              Gap(10),
              ListTile(
                onTap: () {
                  setState(() {
                    selectedMethod = "visa";
                  });
                },
                contentPadding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                tileColor: AppColors.grayColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                leading: Image.asset("assets/icons/visa.png", width: 50),
                title: CustomText(
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
                  child: Radio(activeColor: AppColors.primary, value: "visa"),
                ),
              ),
              Gap(5),
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
                  CustomText(
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


