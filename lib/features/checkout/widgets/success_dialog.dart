import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content tightly
            children: [
              // Success Checkmark Icon
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: Color(0xFF06441C), // Deep green background
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 44),
              ),
              Gap(20),

              CustomText(
                text: 'Success !',
                textColor: AppColors.primary,
                textWeight: FontWeight.bold,
                textSize: 20,
              ),
              Gap(16),

              CustomText(
                text:
                    'Your payment was successful.\nA receipt for this purchase has\nbeen sent to your email.',
                textSize: 14,
                textColor: Colors.grey,
              ),

              Gap(20),
              CustomButton(
                text: "Close",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
