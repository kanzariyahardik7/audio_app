import 'package:flutter/material.dart';
import 'package:my_audio_app/theme/theme.dart';
import 'package:my_audio_app/view/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: lightTheme, home: const SplashScreen());
  }
}
