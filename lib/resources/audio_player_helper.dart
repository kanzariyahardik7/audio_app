import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';

import 'package:my_audio_app/resources/audio_service.dart';

class MusicPlayerHelper {
  static final MusicPlayerHelper _instance = MusicPlayerHelper._internal();
  factory MusicPlayerHelper() => _instance;

  final AudioPlayer _player = AudioPlayer();
  ConcatenatingAudioSource? _playlist;

  AudioPlayer get player => _player;

  late final AudioHandler _audioHandler;

  MusicPlayerHelper._internal() {
    _init();
  }

  Future<void> _init() async {
    _audioHandler = await AudioService.init(
      builder: () => AudioServiceHandler(_player),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.my_audio_app.channel.audio',
        androidNotificationChannelName: 'Music Playback',
        androidNotificationOngoing: true,
      ),
    );

    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  Future<void> setAudioList(
    List<String> filePaths,
    List<MediaItem> mediaItems,
  ) async {
    if (_playlist == null) {
      _playlist = ConcatenatingAudioSource(
        children: filePaths.map((path) {
          final uri = Uri.file(path);
          return AudioSource.uri(uri);
        }).toList(),
      );

      await _player.setAudioSource(_playlist!);
      await _player.setLoopMode(LoopMode.off);
      await _player.setShuffleModeEnabled(false);
    }

    // 💡 Add this:
    (_audioHandler as AudioServiceHandler).setMediaItems(mediaItems);
  }

  Future<void> playAtIndex(int index, MediaItem mediaItem) async {
    await _player.seek(Duration.zero, index: index);

    final item = mediaItem;

    // Send metadata to AudioService
    (_audioHandler as AudioServiceHandler).setMediaItemInfo(item);

    await _player.play();
    _audioHandler.play();
  }

  void play() {
    _player.play();
    _audioHandler.play();
  }

  void pause() {
    _player.pause();
    _audioHandler.pause();
  }

  void resume() => play();

  void stop() {
    _player.stop();
    _audioHandler.stop();
  }

  void dispose() {
    _player.dispose();
    _audioHandler.stop();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
    _audioHandler.seek(position);
  }

  void seekToNext() {
    _player.seekToNext();
    _audioHandler.skipToNext();
  }

  void seekToPrevious() {
    _player.seekToPrevious();
    _audioHandler.skipToPrevious();
  }

  void setShuffleModeEnabled(bool enable) =>
      _player.setShuffleModeEnabled(enable);

  void setLoopMode(LoopMode mode) => _player.setLoopMode(mode);
}
