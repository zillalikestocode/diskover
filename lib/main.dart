import 'package:flutter/material.dart';
import 'package:image_gallery/screens/intro_screen.dart';
import 'package:image_gallery/themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: const IntroScreen(),
    );
  }
}
