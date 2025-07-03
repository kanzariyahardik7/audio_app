import 'package:my_audio_app/app_dependency/service_locator.dart';
import 'package:my_audio_app/main.dart';
import 'package:my_audio_app/view_model/audio_player_vm.dart';
import 'package:my_audio_app/view_model/theme_provider.dart';
import 'package:provider/provider.dart';

class Providers {
  MultiProvider initializeProviders() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AudioPlayerViewModel>(
          create: (_) => getIt<AudioPlayerViewModel>(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => getIt<ThemeProvider>(),
        ),
      ],
      child: MyApp(),
    );
  }
}
