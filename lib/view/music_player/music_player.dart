import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_audio_app/model/music_details_model.dart';
import 'package:my_audio_app/resources/music_helper.dart';

class MusicPlayerPage extends StatefulWidget {
  final MusicDetailsModel musicDetailsModel;
  const MusicPlayerPage({super.key, required this.musicDetailsModel});

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  final MusicHelper _musicHelper = MusicHelper();
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();

    _musicHelper.playMusic(widget.musicDetailsModel.musicUrl);

    _musicHelper.positionStream.listen((pos) {
      setState(() => _currentPosition = pos);
    });

    _musicHelper.durationStream.listen((dur) {
      if (dur != null) setState(() => _totalDuration = dur);
    });
  }

  @override
  void dispose() {
    _musicHelper.player.stop();
    super.dispose();
  }

  String formatDuration(Duration d) =>
      d.toString().split('.').first.padLeft(8, "0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.musicDetailsModel.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.musicDetailsModel.artist,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Spacer(),

              const Icon(Icons.music_note, size: 100, color: Colors.white70),

              const SizedBox(height: 40),

              // Position + buffer slider
              Row(
                children: [
                  Text(
                    formatDuration(_currentPosition),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Expanded(
                    child: StreamBuilder<Duration>(
                      stream: _musicHelper.bufferedPositionStream,
                      builder: (context, bufferedSnapshot) {
                        final buffered = bufferedSnapshot.data ?? Duration.zero;

                        return Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbShape: SliderComponentShape.noThumb,
                                activeTrackColor: Colors.white24,
                                inactiveTrackColor: Colors.white12,
                                trackHeight: 2,
                              ),
                              child: Slider(
                                value: buffered.inSeconds.toDouble().clamp(
                                  0,
                                  _totalDuration.inSeconds.toDouble(),
                                ),
                                min: 0,
                                max: _totalDuration.inSeconds.toDouble(),
                                onChanged: null,
                              ),
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Colors.transparent,
                                thumbColor: Colors.white,
                                trackHeight: 2,
                              ),
                              child: Slider(
                                value: _currentPosition.inSeconds
                                    .toDouble()
                                    .clamp(
                                      0,
                                      _totalDuration.inSeconds.toDouble(),
                                    ),
                                min: 0,
                                max: _totalDuration.inSeconds.toDouble(),
                                onChanged: (value) {
                                  _musicHelper.player.seek(
                                    Duration(seconds: value.toInt()),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Text(
                    formatDuration(_totalDuration),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.skip_previous,
                      size: 32,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.replay_10,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _musicHelper.player.seek(
                        _currentPosition - const Duration(seconds: 10),
                      );
                    },
                  ),
                  StreamBuilder<PlayerState>(
                    stream: _musicHelper.playerStateStream,
                    builder: (context, snapshot) {
                      final isPlaying = snapshot.data?.playing ?? false;
                      return IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 36,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          isPlaying
                              ? _musicHelper.pause()
                              : _musicHelper.player.play();
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.forward_10,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _musicHelper.player.seek(
                        _currentPosition + const Duration(seconds: 10),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.skip_next,
                      size: 32,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
