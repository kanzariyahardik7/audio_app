import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalMusicList extends StatefulWidget {
  const LocalMusicList({super.key});

  @override
  State<LocalMusicList> createState() => _LocalMusicListState();
}

class _LocalMusicListState extends State<LocalMusicList> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  List<SongModel> songs = [];

  @override
  void initState() {
    super.initState();
    _fetchSongs();
  }

  Future<void> _fetchSongs() async {
    // Ask for permission
    if (!(await _audioQuery.permissionsStatus())) {
      await _audioQuery.permissionsRequest();
    }

    // If still not granted, open settings
    if (!(await Permission.storage.isGranted)) {
      await openAppSettings();
      return;
    }

    // Get songs
    songs = await _audioQuery.querySongs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Local Audio Files")),
      body: songs.isEmpty
          ? const Center(child: Text("No songs found"))
          : ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return ListTile(
                  leading: const Icon(Icons.music_note),
                  title: Text(song.title),
                  subtitle: Text(song.artist ?? "Unknown Artist"),
                  onTap: () {},
                );
              },
            ),
    );
  }
}
