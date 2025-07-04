import 'package:get_it/get_it.dart';
import 'package:my_audio_app/view_model/audio_player_vm.dart';
import 'package:my_audio_app/view_model/theme_provider.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // ViewModels (ChangeNotifiers)
  getIt.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
  getIt.registerLazySingleton<AudioPlayerViewModel>(
    () => AudioPlayerViewModel(),
  );
}
