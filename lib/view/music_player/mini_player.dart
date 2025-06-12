// =============================
// views/mini_player.dart
// =============================
import 'package:flutter/material.dart';
import 'package:my_audio_app/view/music_player/music_player.dart';
import 'package:my_audio_app/view_model/audio_player_vm.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerVM>(
      builder: (context, vm, _) {
        if (!vm.isMiniPlayerVisible || vm.currentAudio == null) {
          return const SizedBox.shrink();
        }
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FullPlayerPage()),
          ),
          child: Container(
            color: Colors.black12,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(Icons.music_note),
                const SizedBox(width: 10),
                Expanded(child: Text(vm.currentAudio!.title)),
                IconButton(
                  icon: Icon(
                    vm.player.playing ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: vm.togglePlayPause,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
