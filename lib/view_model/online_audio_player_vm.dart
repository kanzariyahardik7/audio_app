import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_audio_app/model/music_details_model.dart';
import 'package:my_audio_app/resources/constant.dart';
import 'package:my_audio_app/resources/music_player_service.dart';

class OnlineAudioPlayerVM extends ChangeNotifier {
  OnlineAudioPlayerVM() {
    listenToIndexChanges();
    listenToCompletion(); // ✅ added
  }

  /// ✅ Listen for current index change (e.g., user tapped next/previous or auto play)
  void listenToIndexChanges() {
    player.currentIndexStream.listen((index) {
      if (index != null) {
        currentAudioIndex = index;
        isMiniPlayerVisible = true;
        notifyListeners();
      }
    });
  }

  /// ✅ Listen for playback completion (if needed to force next manually)
  void listenToCompletion() {
    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        // Only manually move to next if needed
        if (loopMode != LoopMode.one) {
          _audioService.seekToNext();
        }
      }
    });
  }

  final MusicPlayerService _audioService = MusicPlayerService();

  int? currentAudioIndex;

  bool isMiniPlayerVisible = false;

  final List<AudioModel> audios = [
    AudioModel(title: "Song 1", url: song1, artist: "Artist 1"),
    AudioModel(title: "Song 2", url: song2, artist: "Artist 2"),
    AudioModel(title: "Song 3", url: song3, artist: "Artist 3"),
    AudioModel(title: "Song 4", url: song4, artist: "Artist 4"),
    AudioModel(title: "Song 5", url: song5, artist: "Artist 5"),
  ];

  AudioPlayer get player => _audioService.player;

  Stream<Duration> get positionStream => player.positionStream;
  Stream<Duration?> get durationStream => player.durationStream;

  bool get isPlaying => player.playing;
  bool get isShuffling => player.shuffleModeEnabled;
  LoopMode get loopMode => player.loopMode;
  Duration get currentPosition => player.position;
  Duration get duration => player.duration ?? Duration.zero;

  void play(int index) async {
    final urls = audios.map((e) => e.url).toList();
    isMiniPlayerVisible = true;
    currentAudioIndex = index;
    notifyListeners();
    await _audioService.setAudioList(urls);
    await _audioService.playAtIndex(index);
    notifyListeners();
  }

  void togglePlayPause() {
    isPlaying ? _audioService.pause() : _audioService.resume();
    notifyListeners();
  }

  Future<void> seek(Duration duration) async {
    await _audioService.seek(duration);
    notifyListeners();
  }

  void skipForward10Seconds() {
    final newPosition = currentPosition + Duration(seconds: 10);
    // Ensure it doesn't go beyond total duration
    if (newPosition < duration) {
      seek(newPosition);
    } else {
      seek(duration);
    }
    // notifyListeners();
  }

  void skipBackward10Seconds() {
    // Ensure it doesn't go below zero
    final newPosition = currentPosition - Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      seek(newPosition);
    } else {
      seek(Duration.zero);
    }
    // notifyListeners();
  }

  void playNextSong() {
    if (currentAudioIndex == null) return;
    _audioService.seekToNext(); // ✅ correct
    if (!isPlaying) _audioService.play();
    notifyListeners();
  }

  void playPreviousSong() {
    if (currentAudioIndex == null) return;
    _audioService.seekToPrevious(); // ✅ correct
    if (!isPlaying) _audioService.play();
    notifyListeners();
  }

  void toggleShuffle() {
    _audioService.setShuffleModeEnabled(!isShuffling);
    notifyListeners();
  }

  void toggleLoop() {
    LoopMode next = (loopMode == LoopMode.off) ? LoopMode.one : LoopMode.off;
    _audioService.setLoopMode(next);
    notifyListeners();
  }

  void disposePlayer() {
    _audioService.dispose();
  }
}
