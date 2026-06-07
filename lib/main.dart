import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungry/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // this is to make user cant make the screen in landScape mode
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hungry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.transparent,
      ),
      home: const SplashView(),
    );
  }
}
