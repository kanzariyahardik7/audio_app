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
  bool isShuffling = false;
  LoopMode loopMode = LoopMode.off;

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

    _musicHelper.player.shuffleModeEnabledStream.listen((enabled) {
      setState(() => isShuffling = enabled);
    });

    _musicHelper.player.loopModeStream.listen((mode) {
      setState(() => loopMode = mode);
    });
  }

  @override
  void dispose() {
    _musicHelper.player.stop();
    super.dispose();
  }

  String formatDuration(Duration d) =>
      d.toString().split('.').first.padLeft(5, "0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Top bar
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.musicDetailsModel.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
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
                    ),
                  ],
                ),

                const Spacer(),

                // Album Art
                Container(
                  height: 240,
                  width: 240,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.music_note,
                    size: 100,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 40),

                // Buffer + Playback slider
                Row(
                  children: [
                    Text(
                      formatDuration(_currentPosition),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: StreamBuilder<Duration>(
                        stream: _musicHelper.bufferedPositionStream,
                        builder: (context, snapshot) {
                          final buffered = snapshot.data ?? Duration.zero;

                          return Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              // Buffered
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: SliderComponentShape.noThumb,
                                  activeTrackColor: Colors.white24,
                                  inactiveTrackColor: Colors.white12,
                                  trackHeight: 3,
                                ),
                                child: Slider(
                                  value: buffered.inSeconds
                                      .clamp(0, _totalDuration.inSeconds)
                                      .toDouble(),
                                  min: 0,
                                  max: _totalDuration.inSeconds.toDouble(),
                                  onChanged: null,
                                ),
                              ),
                              // Position
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Colors.white,
                                  inactiveTrackColor: Colors.transparent,
                                  thumbColor: Colors.white,
                                  trackHeight: 3,
                                ),
                                child: Slider(
                                  value: _currentPosition.inSeconds
                                      .clamp(0, _totalDuration.inSeconds)
                                      .toDouble(),
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

                // Playback controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    controlButton(Icons.skip_previous, () {}),
                    controlButton(Icons.replay_10, () {
                      _musicHelper.player.seek(
                        _currentPosition - const Duration(seconds: 10),
                      );
                    }),
                    StreamBuilder<PlayerState>(
                      stream: _musicHelper.playerStateStream,
                      builder: (context, snapshot) {
                        final isPlaying = snapshot.data?.playing ?? false;
                        return controlButton(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          () {
                            isPlaying
                                ? _musicHelper.pause()
                                : _musicHelper.player.play();
                          },
                          size: 50,
                        );
                      },
                    ),
                    controlButton(Icons.forward_10, () {
                      _musicHelper.player.seek(
                        _currentPosition + const Duration(seconds: 10),
                      );
                    }),
                    controlButton(Icons.skip_next, () {}),
                  ],
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controlToggleButton(
                      icon: Icons.shuffle,
                      isActive: isShuffling,
                      onTap: () {
                        final newValue = !isShuffling;
                        _musicHelper.player.setShuffleModeEnabled(newValue);
                        setState(() => isShuffling = newValue);
                      },
                    ),
                    const SizedBox(width: 24),
                    controlToggleButton(
                      icon: loopMode == LoopMode.one
                          ? Icons.repeat_one
                          : Icons.repeat,
                      isActive: loopMode != LoopMode.off,
                      onTap: () {
                        final nextLoop = loopMode == LoopMode.off
                            ? LoopMode.one
                            : loopMode == LoopMode.one
                            ? LoopMode.off
                            : LoopMode.off;
                        _musicHelper.player.setLoopMode(nextLoop);
                        setState(() => loopMode = nextLoop);
                      },
                    ),
                  ],
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget controlToggleButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Colors.white24 : Colors.white10,
          border: Border.all(color: Colors.white30),
        ),
        child: Icon(
          icon,
          size: 26,
          color: isActive ? Colors.white : Colors.white60,
        ),
      ),
    );
  }

  Widget controlButton(IconData icon, VoidCallback onTap, {double size = 36}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white10,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        iconSize: size,
        onPressed: onTap,
      ),
    );
  }
}
