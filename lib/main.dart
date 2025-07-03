import 'package:flutter/material.dart';
import 'package:my_audio_app/app_dependency/dependancy.dart';
import 'package:my_audio_app/app_dependency/service_locator.dart';
import 'package:my_audio_app/theme/app_theme.dart';
import 'package:my_audio_app/view/splash/splash.dart';
import 'package:my_audio_app/view_model/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(Providers().initializeProviders());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App Theme Demo',
      themeMode: provider.themeMode,
      theme: AppTheme.light(provider.primaryColor),
      darkTheme: AppTheme.dark(provider.primaryColor),
      home: const SplashScreen(),
    );
  }
}
