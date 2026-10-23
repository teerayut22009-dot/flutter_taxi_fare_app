import 'dart:async';

import 'package:flutter/material.dart';

import 'taxi_fare_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TaxiFareUi()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/smart_taxi.png',
              height: 300,
              width: 250,
            ),
   const SizedBox(height: 12),

const Text(
  'Taxi Fare Calculator',
  style: TextStyle(
    color: Color(0xFF4AA6FF),
    fontWeight: FontWeight.w500,
    fontSize: 30,
  ),
),

const SizedBox(height: 7),

const Text(
  'คำนวณค่าโดยสารแท็กซี่',
  style: TextStyle(
    color: Color.fromARGB(255, 37, 38, 39),
    fontSize: 20,
  ),
),

const SizedBox(height: 24),

const SizedBox(
  height: 27,
  width: 27,
  child: CircularProgressIndicator(
    color: Color(0xFFFFBE00),
    strokeWidth: 3,
  ),
),
          ],
        ),
      ),
    );
  }
}
