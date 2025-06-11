import 'package:just_audio/just_audio.dart';
import 'package:my_audio_app/resources/colors.dart';
import 'package:my_audio_app/resources/utils.dart';

class MusicHelper {
  static final MusicHelper _instance = MusicHelper._internal();
  factory MusicHelper() => _instance;
  MusicHelper._internal();

  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<void> playMusic(String url) async {
    try {
      await _player.setUrl(url);
      await _player.play();
    } catch (e) {
      Utils.toastMessage("Error playing music: $e", MyColors.red);
    }
  }

  void pause() => _player.pause();

  void dispose() => _player.dispose();

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
}
