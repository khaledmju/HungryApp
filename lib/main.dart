import 'package:flutter/material.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/splash.dart';

import 'features/auth/view/signup_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hungry',
      debugShowCheckedModeBanner: false,
      home: SignupView(),
    );
  }
}
