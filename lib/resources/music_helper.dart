import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() => _instance;

  final AudioPlayer _player = AudioPlayer();
  ConcatenatingAudioSource? _playlist;

  AudioPlayer get player => _player;

  AudioPlayerService._internal();

  Future<void> setAudioList(List<String> urls) async {
    _playlist = ConcatenatingAudioSource(
      children: urls.map((url) => AudioSource.uri(Uri.parse(url))).toList(),
    );
    await _player.setAudioSource(_playlist!);
  }

  Future<void> playAtIndex(int index) async {
    await _player.seek(Duration.zero, index: index);
    await _player.play();
  }

  void pause() => _player.pause();
  void resume() => _player.play();
  void skipNext() => _player.seekToNext();
  void skipPrevious() => _player.seekToPrevious();
  void toggleShuffle(bool enable) => _player.setShuffleModeEnabled(enable);
  void setLoopMode(LoopMode mode) => _player.setLoopMode(mode);
}
