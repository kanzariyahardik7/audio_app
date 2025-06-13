import 'package:just_audio/just_audio.dart';

class MusicPlayerService {
  static final MusicPlayerService _instance = MusicPlayerService._internal();
  factory MusicPlayerService() => _instance;

  final AudioPlayer _player = AudioPlayer();
  ConcatenatingAudioSource? _playlist;

  AudioPlayer get player => _player;

  MusicPlayerService._internal();

  Future<void> setAudioList(List<String> urls) async {
    if (_playlist == null) {
      _playlist = ConcatenatingAudioSource(
        children: urls.map((url) => AudioSource.uri(Uri.parse(url))).toList(),
      );
      await _player.setAudioSource(_playlist!);

      // ✅ Set loop mode to off or all (optional but recommended)
      await _player.setLoopMode(LoopMode.off);

      // ✅ Enable auto-advance
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
