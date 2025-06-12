// =============================
// views/audio_list_page.dart
// =============================
import 'package:flutter/material.dart';
import 'package:my_audio_app/resources/constant.dart';
import 'package:my_audio_app/view/music_player/mini_player.dart';
import 'package:my_audio_app/view_model/audio_player_vm.dart';
import 'package:provider/provider.dart';

class AudioListPage extends StatelessWidget {
  const AudioListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio List")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: audios.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(audios[index].title),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () => Provider.of<AudioPlayerVM>(
                      context,
                      listen: false,
                    ).play(audios[index], audios),
                  ),
                );
              },
            ),
          ),
          const MiniPlayer(),
        ],
      ),
    );
  }
}
