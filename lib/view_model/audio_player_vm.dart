import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_audio_app/model/music_details_model.dart';
import 'package:my_audio_app/resources/music_helper.dart';

class AudioPlayerVM extends ChangeNotifier {
  final AudioPlayerService _audioService = AudioPlayerService();
  AudioModel? currentAudio;
  bool isMiniPlayerVisible = false;

  AudioPlayer get player => _audioService.player;

  void play(AudioModel audio, List<AudioModel> list) async {
    final urls = list.map((e) => e.url).toList();
    final index = list.indexOf(audio);
    currentAudio = audio;
    isMiniPlayerVisible = true;
    await _audioService.setAudioList(urls);
    await _audioService.playAtIndex(index);
    notifyListeners();
  }

  void togglePlayPause() {
    if (player.playing) {
      _audioService.pause();
    } else {
      _audioService.resume();
    }
    notifyListeners();
  }
}
