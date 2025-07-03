import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_audio_app/view_model/audio_player_vm.dart';
import 'package:provider/provider.dart';

class FullPlayerPage extends StatelessWidget {
  const FullPlayerPage({super.key});

  String format(Duration d) => d.toString().split('.').first;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AudioPlayerViewModel>(context);
    final colorScheme = Theme.of(context).colorScheme;

    final currentIndex = vm.currentAudioIndex;
    final currentAudio = currentIndex != null ? vm.audios[currentIndex] : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentAudio?.title ?? 'Now Playing',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
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
                gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.primaryContainer],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                Icons.music_note,
                size: 100,
                color: colorScheme.onPrimary,
              ),
            ),

            const SizedBox(height: 40),

            // Song Title
            Text(
              currentAudio?.title ?? 'Unknown Title',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                CircleAvatar(
                  radius: 30,
                  backgroundColor: colorScheme.primary,
                  child: IconButton(
                    icon: Icon(
                      vm.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: colorScheme.onPrimary,
                      size: 36,
                    ),
                    onPressed: vm.togglePlayPause,
                  ),
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
