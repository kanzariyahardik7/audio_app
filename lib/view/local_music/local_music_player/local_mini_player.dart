import 'package:flutter/material.dart';
import 'package:my_audio_app/view/local_music/local_music_player/local_music_player.dart';
import 'package:my_audio_app/view_model/local_audio_player_vm.dart';
import 'package:provider/provider.dart';

class LocalMiniPlayer extends StatelessWidget {
  const LocalMiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalAudioPlayerVM>(
      builder: (context, vm, _) {
        final index = vm.currentAudioIndex;
        if (!vm.isMiniPlayerVisible || index == null) {
          return const SizedBox.shrink();
        }

        final currentAudio = vm.audioFiles[index];

        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LocalFullPlayerPage()),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.music_note),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    currentAudio.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                StreamBuilder<bool>(
                  stream: vm.player.playingStream,
                  initialData: vm.player.playing,
                  builder: (context, snapshot) {
                    final isPlaying = snapshot.data ?? false;
                    return GestureDetector(
                      onTap: vm.togglePlayPause,
                      child: AbsorbPointer(
                        child: IconButton(
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                          onPressed: null,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
