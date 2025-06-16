import 'package:flutter/material.dart';
import 'package:my_audio_app/view/online_music/online_music_player/online_music_player.dart';
import 'package:my_audio_app/view_model/online_audio_player_vm.dart';
import 'package:provider/provider.dart';

class OnlineMiniPlayer extends StatelessWidget {
  const OnlineMiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnlineAudioPlayerVM>(
      builder: (context, vm, _) {
        final index = vm.currentAudioIndex;
        if (!vm.isMiniPlayerVisible || index == null) {
          return const SizedBox.shrink();
        }

        final currentAudio = vm.audios[index];

        return Material(
          color: Colors.black12,
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FullPlayerPage()),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
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
          ),
        );
      },
    );
  }
}
