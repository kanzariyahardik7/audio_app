import 'package:flutter/material.dart';
import 'package:my_audio_app/view/local_music/local_music_player/local_music_player.dart';
import 'package:my_audio_app/view_model/local_audio_player_vm.dart';
import 'package:provider/provider.dart';

class LocalMiniPlayer extends StatelessWidget {
  const LocalMiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    final textColor = colorScheme.onSurface;

    return Consumer<LocalAudioPlayerVM>(
      builder: (context, vm, _) {
        final index = vm.currentAudioIndex;
        if (!vm.isMiniPlayerVisible || index == null) {
          return const SizedBox.shrink();
        }

        final currentAudio = vm.audios[index];

        return Material(
          color: primaryColor,
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LocalFullPlayerPage()),
            ),
            child: SizedBox(
              height: 80,
              width: double.infinity,
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: textColor.withOpacity(0.15),
                    child: Icon(Icons.music_note, color: textColor, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentAudio.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          currentAudio.artist.isNotEmpty
                              ? currentAudio.artist
                              : "Online Audio",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: textColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  StreamBuilder<bool>(
                    stream: vm.player.playingStream,
                    initialData: vm.player.playing,
                    builder: (context, snapshot) {
                      final isPlaying = snapshot.data ?? false;
                      return IconButton(
                        onPressed: vm.togglePlayPause,
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: textColor,
                          size: 30,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
