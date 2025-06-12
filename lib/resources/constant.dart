import 'package:my_audio_app/model/music_details_model.dart';

const String song1 = "https://gennii.com/test_audio/1_copy.mpeg";
const String song2 = "https://gennii.com/test_audio/2_copy.mpeg";
const String song3 = "https://gennii.com/test_audio/3_copy.mpeg";
const String song4 = "https://gennii.com/test_audio/4_copy.mpeg";
const String song5 = "https://gennii.com/test_audio/5_copy.mpeg";

final List<AudioModel> audios = [
  AudioModel(title: "Song 1", url: song1, artist: "Artist 1"),
  AudioModel(title: "Song 2", url: song2, artist: "Artist 2"),
  AudioModel(title: "Song 3", url: song3, artist: "Artist 3"),
  AudioModel(title: "Song 4", url: song4, artist: "Artist 4"),
  AudioModel(title: "Song 5", url: song5, artist: "Artist 5"),
];
