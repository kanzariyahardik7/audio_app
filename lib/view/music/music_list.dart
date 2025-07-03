import 'package:flutter/material.dart';
import 'package:my_audio_app/view/music/music_player/mini_player.dart';
import 'package:my_audio_app/view_model/audio_player_vm.dart';
import 'package:provider/provider.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  late AudioPlayerViewModel localAudioPlayerVM;

  @override
  void initState() {
    super.initState();
    localAudioPlayerVM = Provider.of<AudioPlayerViewModel>(
      context,
      listen: false,
    );
    localAudioPlayerVM.requestPermissionAndFetch();
  }

  @override
  void dispose() {
    localAudioPlayerVM.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = colorScheme.primary;
    final textColor = colorScheme.onSurface;
    final bgColor = theme.scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Local Music',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: bgColor,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<AudioPlayerViewModel>(
                builder: (context, value, child) {
                  if (value.audios.isEmpty) {
                    return Center(
                      child: Text(
                        'No local audio files found',
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    itemCount: value.audios.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final audio = value.audios[index];
                      return InkWell(
                        onTap: () => value.play(index),
                        borderRadius: BorderRadius.circular(16),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: primaryColor.withOpacity(0.1),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.04),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 12,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: primaryColor.withOpacity(
                                    0.15,
                                  ),
                                  child: Icon(
                                    Icons.audiotrack,
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        audio.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.w600,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        audio.artist.isNotEmpty
                                            ? audio.artist
                                            : 'Unknown Artist',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          color: textColor.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Icon(
                                  Icons.play_arrow,
                                  size: 26,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const MiniPlayer(),
          ],
        ),
      ),
    );
  }
}
