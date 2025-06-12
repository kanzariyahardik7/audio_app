// =============================
// views/full_player_page.dart
// =============================
import 'package:flutter/material.dart';
import 'package:my_audio_app/view_model/audio_player_vm.dart';
import 'package:provider/provider.dart';

class FullPlayerPage extends StatelessWidget {
  const FullPlayerPage({super.key});

  String format(Duration d) => d.toString().split('.').first;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AudioPlayerVM>(context);
    final player = vm.player;

    return Scaffold(
      appBar: AppBar(title: Text(vm.currentAudio?.title ?? "Player")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Spacer(),
            StreamBuilder<Duration>(
              stream: player.positionStream,
              builder: (_, snapshot) {
                final pos = snapshot.data ?? Duration.zero;
                return StreamBuilder<Duration?>(
                  stream: player.durationStream,
                  builder: (_, snap) {
                    final total = snap.data ?? Duration.zero;
                    return Column(
                      children: [
                        Slider(
                          value: pos.inSeconds.toDouble(),
                          max: total.inSeconds.toDouble() + 1,
                          onChanged: (v) =>
                              player.seek(Duration(seconds: v.toInt())),
                        ),
                        Text("${format(pos)} / ${format(total)}"),
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
                  onPressed: player.seekToPrevious,
                ),
                IconButton(
                  icon: Icon(player.playing ? Icons.pause : Icons.play_arrow),
                  onPressed: vm.togglePlayPause,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: player.seekToNext,
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
