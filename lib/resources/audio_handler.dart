// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';

// Future<AudioHandler> initAudioServiceHandler() async {
//   final player = AudioPlayer();

//   final audioHandler = await AudioService.init(
//     builder: () => MyAudioHandler(player),
//     config: const AudioServiceConfig(
//       androidNotificationChannelId: 'com.yourapp.channel.audio',
//       androidNotificationChannelName: 'Audio Playback',
//       androidNotificationOngoing: true,
//     ),
//   );
//   return audioHandler;
// }

// class MyAudioHandler extends BaseAudioHandler with SeekHandler {
//   final AudioPlayer _player;

//   MyAudioHandler(this._player) {
//     _notifyAudioHandlerAboutPlaybackEvents();
//   }

//   void _notifyAudioHandlerAboutPlaybackEvents() {
//     _player.playbackEventStream.listen((event) {
//       playbackState.add(
//         playbackState.value.copyWith(
//           controls: [
//             MediaControl.skipToPrevious,
//             _player.playing ? MediaControl.pause : MediaControl.play,
//             MediaControl.skipToNext,
//           ],
//           playing: _player.playing,
//           processingState: {
//             ProcessingState.idle: AudioProcessingState.idle,
//             ProcessingState.loading: AudioProcessingState.loading,
//             ProcessingState.buffering: AudioProcessingState.buffering,
//             ProcessingState.ready: AudioProcessingState.ready,
//             ProcessingState.completed: AudioProcessingState.completed,
//           }[_player.processingState]!,
//         ),
//       );
//     });
//   }

//   @override
//   Future<void> play() => _player.play();

//   @override
//   Future<void> pause() => _player.pause();

//   @override
//   Future<void> seek(Duration position) => _player.seek(position);

//   @override
//   Future<void> stop() => _player.stop();
// }
