import 'package:flutter/material.dart';

class CustomProfileTextField extends StatelessWidget {
  const CustomProfileTextField({super.key, required this.controller, required this.labelText});

  final TextEditingController controller ;
  final String labelText ;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.white,
      cursorHeight: 20,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
