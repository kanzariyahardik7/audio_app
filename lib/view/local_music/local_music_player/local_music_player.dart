// =============================
// views/full_player_page.dart
// =============================
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          vm.currentAudioIndex != null
              ? vm.audioFiles[vm.currentAudioIndex!].title
              : "Now Playing",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Spacer(),
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
                        Slider(
                          value: pos.inSeconds.toDouble(),
                          max: total.inSeconds.toDouble() + 1,
                          onChanged: (value) {},
                          onChangeEnd: (v) =>
                              vm.seek(Duration(seconds: v.toInt())),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text(format(pos)), Text(format(total))],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  onPressed: vm.playPreviousSong,
                ),

                IconButton(
                  icon: Icon(Icons.replay_10),
                  onPressed: vm.skipBackward10Seconds,
                ),

                IconButton(
                  icon: Icon(vm.isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: vm.togglePlayPause,
                ),
                IconButton(
                  icon: Icon(Icons.forward_10),
                  onPressed: vm.skipForward10Seconds,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: vm.playNextSong,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    vm.isShuffling ? Icons.shuffle_on_outlined : Icons.shuffle,
                  ),
                  onPressed: vm.toggleShuffle,
                ),
                IconButton(
                  icon: Icon(
                    vm.loopMode == LoopMode.one
                        ? Icons.repeat_one
                        : Icons.repeat,
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
