// =============================
// views/audio_list_page.dart
// =============================
import 'package:flutter/material.dart';
import 'package:my_audio_app/view/music_player/mini_player.dart';
import 'package:my_audio_app/view_model/audio_player_vm.dart';
import 'package:provider/provider.dart';

class AudioListPage extends StatefulWidget {
  const AudioListPage({super.key});

  @override
  State<AudioListPage> createState() => _AudioListPageState();
}

class _AudioListPageState extends State<AudioListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio List")),
      body: Column(
        children: [
          Expanded(
            child: Consumer<AudioPlayerVM>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.audios.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(value.audios[index].title),
                      onTap: () => value.play(index),
                    );
                  },
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
