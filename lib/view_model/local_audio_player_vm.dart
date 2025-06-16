import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_audio_app/model/local_audio_model.dart';
import 'package:my_audio_app/resources/audio_query.dart';
import 'package:my_audio_app/resources/local_music_player.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalAudioPlayerVM extends ChangeNotifier {
  LocalAudioPlayerVM() {
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

  List<LocalAudio> audioFiles = [];

  Future<void> requestPermissionAndFetch() async {
    await [Permission.storage, Permission.audio].request();

    final rawList = await AudioQuery().getAllAudio();

    // Safely cast and convert to model list
    audioFiles = (rawList as List)
        .whereType<Map<dynamic, dynamic>>() // safe filtering
        .map((e) => Map<String, String>.from(e)) // ensure type safety
        .map((map) => LocalAudio.fromMap(map))
        .toList();

    notifyListeners();
  }

  final LocalMusicPlayerService _audioService = LocalMusicPlayerService();

  int? currentAudioIndex;

  bool isMiniPlayerVisible = false;

  AudioPlayer get player => _audioService.player;

  Stream<Duration> get positionStream => player.positionStream;
  Stream<Duration?> get durationStream => player.durationStream;

  bool get isPlaying => player.playing;
  bool get isShuffling => player.shuffleModeEnabled;
  LoopMode get loopMode => player.loopMode;
  Duration get currentPosition => player.position;
  Duration get duration => player.duration ?? Duration.zero;

  /// ✅ Play audio at index from local file path
  void play(int index) async {
    final filePaths = audioFiles
        .map((e) => e.path)
        .toList(); // 🎯 Use local paths
    currentAudioIndex = index;
    isMiniPlayerVisible = true;
    notifyListeners();

    await _audioService.setAudioList(filePaths); // 🆕 set local audio
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
}
