import 'package:flutter/material.dart';

import 'custom_text.dart';

SnackBar customSnackBar(errMas) {
  return SnackBar(
    clipBehavior: Clip.none,
    elevation: 10,
    padding: const EdgeInsets.all(10),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.red.shade900,
    margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
    content: CustomText(
      text: errMas,
      textColor: Colors.white,
      textWeight: FontWeight.w600,
      textSize: 14,
    ),
  );
}
