import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:my_audio_app/resources/colors.dart';
import 'package:my_audio_app/view/music_player/music_player.dart';
import 'package:my_audio_app/view_model/audio_player_vm.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  openMusicPlayerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MyColors.transparent, // to allow custom rounded corners
      builder: (context) => const MusicBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    final textColor = MyColors.white;

    return Consumer<AudioPlayerViewModel>(
      builder: (context, vm, _) {
        final index = vm.currentAudioIndex;
        if (!vm.isMiniPlayerVisible || index == null) {
          return const SizedBox.shrink();
        }

        final currentAudio = vm.audios[index];

        return Material(
          color: primaryColor,
          child: GestureDetector(
            onTap: () {
              openMusicPlayerBottomSheet(context);
            },

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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          width: double.infinity,
                          child: Marquee(
                            text: currentAudio.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: textColor,
                            ),
                            blankSpace: 60.0,
                            velocity: 30.0,

                            pauseAfterRound: Duration(seconds: 1),
                            startPadding: 12.0,
                            accelerationDuration: Duration(seconds: 1),
                            accelerationCurve: Curves.linear,
                            decelerationDuration: Duration(milliseconds: 500),
                            decelerationCurve: Curves.easeOut,
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
                  IconButton(
                    icon: Icon(Icons.skip_previous_rounded, color: textColor),
                    onPressed: vm.playPreviousSong,
                  ),
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
                  IconButton(
                    icon: Icon(Icons.skip_next_rounded, color: textColor),
                    onPressed: vm.playNextSong,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
