import 'package:flutter/material.dart';
import 'package:my_audio_app/view/local_music/local_music_list.dart';
import 'package:my_audio_app/view/online_music/online_music_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Music App")),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OnlineMusicListPage(),
                ),
              );
            },
            child: Text("Online Music"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LocalMusicList()),
              );
            },
            child: Text("Local Music"),
          ),
        ],
      ),
    );
  }
}
