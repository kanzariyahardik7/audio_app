import 'package:flutter/material.dart';
import 'package:my_audio_app/theme/theme.dart';
import 'package:my_audio_app/view/splash/splash.dart';
import 'package:my_audio_app/view_model/local_audio_player_vm.dart';
import 'package:my_audio_app/view_model/online_audio_player_vm.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OnlineAudioPlayerVM>(
          create: (_) => OnlineAudioPlayerVM(),
        ),
        ChangeNotifierProvider<LocalAudioPlayerVM>(
          create: (_) => LocalAudioPlayerVM(),
        ),
      ],
      child: MaterialApp(
        theme: lightTheme,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
