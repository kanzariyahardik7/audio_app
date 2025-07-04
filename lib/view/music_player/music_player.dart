import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_audio_app/app_dependency/service_locator.dart';
import 'package:marquee/marquee.dart';
import 'package:my_audio_app/resources/colors.dart';
import 'package:my_audio_app/view_model/audio_player_vm.dart';

class MusicBottomSheet extends StatelessWidget {
  const MusicBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: FullPlayerPage(scrollController: controller),
        ),
      ),
    );
  }
}

class FullPlayerPage extends StatefulWidget {
  final ScrollController? scrollController;
  const FullPlayerPage({super.key, this.scrollController});

  @override
  State<FullPlayerPage> createState() => _FullPlayerPageState();
}

class _FullPlayerPageState extends State<FullPlayerPage> {
  String format(Duration d) => d.toString().split('.').first;

  @override
  Widget build(BuildContext context) {
    final vm = getIt<AudioPlayerViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    final currentIndex = vm.currentAudioIndex;
    final currentAudio = currentIndex != null ? vm.audios[currentIndex] : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player', overflow: TextOverflow.ellipsis),
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_arrow_down),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Album Art Placeholder
            Container(
              height: 260,
              width: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withOpacity(0.15),
                border: Border.all(color: colorScheme.primary, width: 4),
                gradient: RadialGradient(
                  colors: [
                    colorScheme.primary.withOpacity(0.2),
                    colorScheme.primary.withOpacity(0.05),
                  ],
                  center: Alignment.center,
                  radius: 0.85,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.music_note_rounded,
                  size: 100,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Song Title
            SizedBox(
              height: 30,
              width: double.infinity, // or a fixed width if needed
              child: Marquee(
                text: currentAudio?.title ?? 'Unknown Title',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onBackground,
                ),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 60.0,
                velocity: 40.0,
                pauseAfterRound: Duration(seconds: 1),
                startPadding: 10.0,
                accelerationDuration: Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: Duration(milliseconds: 500),
                decelerationCurve: Curves.easeOut,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              currentAudio?.artist.isNotEmpty == true
                  ? currentAudio!.artist
                  : 'Unknown Artist',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onBackground.withOpacity(0.6),
              ),
            ),

            const SizedBox(height: 30),

            // Seekbar & Duration
            StreamBuilder<Duration>(
              stream: vm.positionStream,
              builder: (_, snapshot) {
                final pos = snapshot.data ?? Duration.zero;
                return StreamBuilder<Duration?>(
                  stream: vm.durationStream,
                  builder: (_, snap) {
                    final total = snap.data ?? Duration.zero;
                    return Column(
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 12,
                            ),
                          ),
                          child: Slider(
                            value: pos.inSeconds.toDouble(),
                            max: total.inSeconds.toDouble() + 1,
                            activeColor: colorScheme.primary,
                            inactiveColor: colorScheme.primary.withOpacity(0.3),
                            onChanged: (value) {},
                            onChangeEnd: (v) =>
                                vm.seek(Duration(seconds: v.toInt())),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              format(pos),
                              style: TextStyle(
                                color: colorScheme.onBackground.withOpacity(
                                  0.6,
                                ),
                              ),
                            ),
                            Text(
                              format(total),
                              style: TextStyle(
                                color: colorScheme.onBackground.withOpacity(
                                  0.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 30),

            // Playback Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous_rounded),
                  iconSize: 36,
                  color: colorScheme.onBackground,
                  onPressed: vm.playPreviousSong,
                ),
                IconButton(
                  icon: const Icon(Icons.replay_10_rounded),
                  iconSize: 36,
                  color: colorScheme.onBackground,
                  onPressed: vm.skipBackward10Seconds,
                ),
                StreamBuilder<bool>(
                  stream: vm.player.playingStream,
                  initialData: vm.isPlaying,
                  builder: (context, snapshot) {
                    final isPlaying = snapshot.data ?? false;
                    return CircleAvatar(
                      radius: 30,
                      backgroundColor: colorScheme.primary,
                      child: IconButton(
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: MyColors.white,
                          size: 36,
                        ),
                        onPressed: vm.togglePlayPause,
                      ),
                    );
                  },
                ),

                IconButton(
                  icon: const Icon(Icons.forward_10_rounded),
                  iconSize: 36,
                  color: colorScheme.onBackground,
                  onPressed: vm.skipForward10Seconds,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next_rounded),
                  iconSize: 36,
                  color: colorScheme.onBackground,
                  onPressed: vm.playNextSong,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Shuffle & Repeat
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    vm.isShuffling ? Icons.shuffle_on : Icons.shuffle,
                    color: vm.isShuffling
                        ? colorScheme.primary
                        : colorScheme.onBackground.withOpacity(0.5),
                  ),
                  onPressed: vm.toggleShuffle,
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(
                    vm.loopMode == LoopMode.one
                        ? Icons.repeat_one
                        : Icons.repeat,
                    color: vm.loopMode != LoopMode.off
                        ? colorScheme.primary
                        : colorScheme.onBackground.withOpacity(0.5),
                  ),
                  onPressed: vm.toggleLoop,
                ),
              ],
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
