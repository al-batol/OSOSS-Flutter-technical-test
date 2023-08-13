import 'package:flutter/material.dart';
import 'package:task_test/pages/home_page.dart';
import 'package:task_test/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final bool isHomePage = false;
  // void
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}