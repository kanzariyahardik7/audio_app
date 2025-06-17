import 'package:flutter/material.dart';
import 'package:my_audio_app/view/local_music/local_music_player/local_mini_player.dart';
import 'package:my_audio_app/view_model/local_audio_player_vm.dart';
import 'package:provider/provider.dart';

class LocalMusicList extends StatefulWidget {
  const LocalMusicList({super.key});

  @override
  State<LocalMusicList> createState() => _LocalMusicListState();
}

class _LocalMusicListState extends State<LocalMusicList> {
  late LocalAudioPlayerVM localAudioPlayerVM;
  @override
  void initState() {
    localAudioPlayerVM = Provider.of<LocalAudioPlayerVM>(
      context,
      listen: false,
    );
    super.initState();

    localAudioPlayerVM.requestPermissionAndFetch();
  }

  @override
  void dispose() {
    localAudioPlayerVM.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Audio Files')),
      body: Column(
        children: [
          Expanded(
            child: Consumer<LocalAudioPlayerVM>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.audioFiles.length,
                  itemBuilder: (context, index) {
                    final audio = value.audioFiles[index];
                    return ListTile(
                      title: Text(audio.title),
                      subtitle: Text(audio.artist),
                      onTap: () => value.play(index),
                    );
                  },
                );
              },
            ),
          ),
          LocalMiniPlayer(),
        ],
      ),
    );
  }
}
