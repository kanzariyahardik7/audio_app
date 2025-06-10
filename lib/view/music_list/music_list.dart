import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_audio_app/resources/constant.dart';
import 'package:my_audio_app/view/music_player/music_player.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({super.key});

  @override
  State<MusicListPage> createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  late AudioPlayer _audioPlayer; // Declare an instance of AudioPlayer
  // Replace with an actual URL of an audio file.
  // Using a sample MP3 from a free audio host for demonstration.
  final String _audioUrl = song1;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // Initialize the audio player
    _initAudioPlayer(); // Call a method to load the audio
  }

  Future<void> _initAudioPlayer() async {
    try {
      // Set the audio source from a network URL
      await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(_audioUrl)));
      // Optionally, you can set initial volume, speed, etc.
      _audioPlayer.setVolume(0.8);
    } catch (e) {
      print("Error loading audio source: $e");
      // You could show a SnackBar or an alert dialog here
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading audio: $e')));
    }
  }

  @override
  void dispose() {
    _audioPlayer
        .dispose(); // Important: Release resources when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Music")),
      // Gradient background for the whole screen
      body: ListView.builder(
        itemCount: musicDataList.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final track = musicDataList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MusicPlayerPage()),
              );
            },
            borderRadius: BorderRadius.circular(
              16.0,
            ), // Match InkWell's ripple to card shape
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  track.artist,
                  style: TextStyle(fontSize: 16.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
