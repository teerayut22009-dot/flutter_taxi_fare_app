import 'package:flutter/material.dart';

import 'screens/splash_screen_ui.dart';

void main() {
  runApp(const TaxiFareApp());
}

class TaxiFareApp extends StatelessWidget {
  const TaxiFareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi Fare',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFFFFF8FF),
        primaryColor: const Color(0xFFFFBE00),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFBE00),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const SplashScreenUi(),
    );
  }
}
