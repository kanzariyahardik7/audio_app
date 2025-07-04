import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_audio_app/model/audio_model.dart';
import 'package:my_audio_app/platform_channels/audio_query.dart';
import 'package:my_audio_app/resources/audio_player_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPlayerViewModel extends ChangeNotifier {
  AudioPlayerViewModel() {
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

  List<AudioModel> audios = [];
  bool isLoading = false;

  setIsLoading(bool flag) {
    isLoading = flag;
    notifyListeners();
  }

  Future<void> requestPermissionAndFetch() async {
    await [Permission.storage, Permission.audio].request();
    setIsLoading(true);
    final rawList = await AudioQuery().getAllAudio();

    // Safely cast and convert to model list
    audios = (rawList as List)
        .whereType<Map<dynamic, dynamic>>() // safe filtering
        .map((e) => Map<String, String>.from(e)) // ensure type safety
        .map((map) => AudioModel.fromMap(map))
        .toList();
    setIsLoading(false);
    notifyListeners();
  }

  final MusicPlayerHelper _audioService = MusicPlayerHelper();

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
    final filePaths = audios.map((e) => e.path).toList();

    final mediaItems = audios.asMap().entries.map((entry) {
      final i = entry.key;
      final e = entry.value;

      return MediaItem(
        id: (i + 1).toString(),
        title: e.title,
        artist: e.artist,
        album: 'Album Name',
        duration: Duration.zero, // Will be updated automatically
        // artUri: Uri.file(e.albumArt ?? ''), // If available
      );
    }).toList();

    currentAudioIndex = index;
    isMiniPlayerVisible = true;
    notifyListeners();

    await _audioService.setAudioList(filePaths, mediaItems);
    await _audioService.playAtIndex(index, mediaItems[index]);

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
  }

  void skipBackward10Seconds() {
    // Ensure it doesn't go below zero
    final newPosition = currentPosition - Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      seek(newPosition);
    } else {
      seek(Duration.zero);
    }
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
    isMiniPlayerVisible = false;
  }
}
