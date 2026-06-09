import 'package:flutter/material.dart';
import 'package:hungry/core/constants/app_colors.dart';

class CustomProfileTextField extends StatelessWidget {
  const CustomProfileTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.inputType,
  });

  final TextEditingController controller;

  final String labelText;
  final String? hintText;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.white,
      cursorHeight: 20,
      style: TextStyle(color: AppColors.primary),
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.primary),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.primary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
