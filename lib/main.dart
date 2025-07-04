import 'package:flutter/material.dart';
import 'package:my_audio_app/app_dependency/dependancy.dart';
import 'package:my_audio_app/app_dependency/service_locator.dart';
import 'package:my_audio_app/theme/app_theme.dart';
import 'package:my_audio_app/view/splash/splash.dart';
import 'package:my_audio_app/view_model/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  runApp(Providers().initializeProviders());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: value.themeMode,
          theme: AppTheme.light(value.primaryColor),
          darkTheme: AppTheme.dark(value.primaryColor),
          home: const SplashScreen(),
        );
      },
    );
  }
}
