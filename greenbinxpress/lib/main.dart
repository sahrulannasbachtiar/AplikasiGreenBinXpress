import 'package:flutter/material.dart';
import 'package:greenbinxpress/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenBinXpress',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 43, 138, 216)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
