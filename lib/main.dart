import 'package:flutter/material.dart';
import 'package:my_audio_app/theme/app_theme.dart';
import 'package:my_audio_app/view/splash/splash.dart';
import 'package:my_audio_app/view_model/local_audio_player_vm.dart';
import 'package:my_audio_app/view_model/online_audio_player_vm.dart';
import 'package:my_audio_app/view_model/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<OnlineAudioPlayerVM>(
          create: (_) => OnlineAudioPlayerVM(),
        ),
        ChangeNotifierProvider<LocalAudioPlayerVM>(
          create: (_) => LocalAudioPlayerVM(),
        ),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
