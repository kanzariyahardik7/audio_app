// =============================
// views/audio_list_page.dart
// =============================
import 'package:flutter/material.dart';
import 'package:my_audio_app/view/online_music/online_music_player/online_mini_player.dart';
import 'package:my_audio_app/view_model/online_audio_player_vm.dart';
import 'package:provider/provider.dart';

class OnlineMusicListPage extends StatefulWidget {
  const OnlineMusicListPage({super.key});

  @override
  State<OnlineMusicListPage> createState() => _OnlineMusicListPageState();
}

class _OnlineMusicListPageState extends State<OnlineMusicListPage> {
  late OnlineAudioPlayerVM onlineAudioPlayerVM;
  @override
  void initState() {
    onlineAudioPlayerVM = Provider.of<OnlineAudioPlayerVM>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    onlineAudioPlayerVM.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Online Audio List")),
      body: Column(
        children: [
          Expanded(
            child: Consumer<OnlineAudioPlayerVM>(
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
          const OnlineMiniPlayer(),
        ],
      ),
    );
  }
}
