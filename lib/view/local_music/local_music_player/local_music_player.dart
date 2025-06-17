import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_audio_app/view_model/local_audio_player_vm.dart';
import 'package:provider/provider.dart';

class LocalFullPlayerPage extends StatelessWidget {
  const LocalFullPlayerPage({super.key});

  String format(Duration d) => d.toString().split('.').first;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LocalAudioPlayerVM>(context);
    final currentIndex = vm.currentAudioIndex;
    final currentAudio = currentIndex != null ? vm.audios[currentIndex] : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentAudio?.title ?? 'Now Playing',
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
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
                gradient: const LinearGradient(
                  colors: [Color(0xFFf953c6), Color(0xFFb91d73)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.music_note,
                size: 100,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 40),

            // Song Title
            Text(
              currentAudio?.title ?? 'Unknown Title',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 10),

            Text(
              currentAudio?.artist.isNotEmpty == true
                  ? currentAudio!.artist
                  : 'Unknown Artist',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                            activeColor: Colors.pink,
                            inactiveColor: Colors.pink.shade100,
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
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              format(total),
                              style: TextStyle(color: Colors.grey),
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
                  onPressed: vm.playPreviousSong,
                ),
                IconButton(
                  icon: const Icon(Icons.replay_10_rounded),
                  iconSize: 36,
                  onPressed: vm.skipBackward10Seconds,
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.pink,
                  child: IconButton(
                    icon: Icon(
                      vm.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                    onPressed: vm.togglePlayPause,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.forward_10_rounded),
                  iconSize: 36,
                  onPressed: vm.skipForward10Seconds,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next_rounded),
                  iconSize: 36,
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
                    color: vm.isShuffling ? Colors.pink : Colors.grey,
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
                        ? Colors.pink
                        : Colors.grey,
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
