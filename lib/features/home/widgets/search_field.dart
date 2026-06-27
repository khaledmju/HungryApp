import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, this.onChanged, required this.controller});

  final void Function(String)? onChanged;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(15),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search...',
          prefixIcon: const Icon(CupertinoIcons.search),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
