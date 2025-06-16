import 'package:just_audio/just_audio.dart';

class LocalMusicPlayerService {
  static final LocalMusicPlayerService _instance =
      LocalMusicPlayerService._internal();
  factory LocalMusicPlayerService() => _instance;

  final AudioPlayer _player = AudioPlayer();
  ConcatenatingAudioSource? _playlist;

  AudioPlayer get player => _player;

  LocalMusicPlayerService._internal();

  Future<void> setAudioList(List<String> filePaths) async {
    if (_playlist == null) {
      _playlist = ConcatenatingAudioSource(
        children: filePaths.map((path) {
          final uri = Uri.file(path); // 🔄 Local file URI
          return AudioSource.uri(uri);
        }).toList(),
      );

      await _player.setAudioSource(_playlist!);
      await _player.setLoopMode(LoopMode.off);
      await _player.setShuffleModeEnabled(false);
    }
  }

  Future<void> playAtIndex(int index) async {
    await _player.seek(Duration.zero, index: index);
    await _player.play();
  }

  void play() => _player.play();
  void pause() => _player.pause();
  void resume() => _player.play();
  void stop() => _player.stop();

  Future<void> seek(Duration position) async => await _player.seek(position);
  void seekToNext() => _player.seekToNext();
  void seekToPrevious() => _player.seekToPrevious();
  void setShuffleModeEnabled(bool enable) =>
      _player.setShuffleModeEnabled(enable);
  void setLoopMode(LoopMode mode) => _player.setLoopMode(mode);
}
