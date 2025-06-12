import 'package:flutter/material.dart';
import 'package:my_audio_app/theme/theme.dart';
import 'package:my_audio_app/view/splash/splash.dart';
import 'package:my_audio_app/view_model/audio_player_vm.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AudioPlayerVM())],
      child: MaterialApp(
        theme: lightTheme,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
// Requirement of audio app in flutter
// 1- play audio using just_audio 
// 2- show audio list and all audio have play button 
// 3- tap of play button music start to play and bottom of the app make mini player on tap of mini player open main music player
// 4- in the music player give feature play and pausse next shuffel, repeate audio controll skipp and back audio , music progress indigator, current time and total time of audio 
// 5- all audio are store at the server i call link to play audio , 
// 6- use stream to play audio

