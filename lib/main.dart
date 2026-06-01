import 'package:flutter/material.dart';
import 'package:hungry/root.dart';
import 'package:hungry/splash.dart';

import 'features/auth/views/signup_view.dart';

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
      home: Root(),
    );
  }
}
