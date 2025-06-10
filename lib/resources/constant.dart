import 'package:my_audio_app/model/music_details_model.dart';

const String song1 = "https://gennii.com/test_audio/1_copy.mpeg";
const String song2 = "https://gennii.com/test_audio/2_copy.mpeg";
const String song3 = "https://gennii.com/test_audio/3_copy.mpeg";
const String song4 = "https://gennii.com/test_audio/4_copy.mpeg";
const String song5 = "https://gennii.com/test_audio/5_copy.mpeg";

List<MusicDetailsModel> musicDataList = [
  MusicDetailsModel(
    id: 1,
    title: 'Song 1',
    artist: 'Artist 1',
    albumArtUrl: song1,
  ),
  MusicDetailsModel(
    id: 2,
    title: 'Song 2',
    artist: 'Artist 2',
    albumArtUrl: song2,
  ),
  MusicDetailsModel(
    id: 3,
    title: 'Song 3',
    artist: 'Artist 3',
    albumArtUrl: song3,
  ),
  MusicDetailsModel(
    id: 4,
    title: 'Song 4',
    artist: 'Artist 4',
    albumArtUrl: song4,
  ),
  MusicDetailsModel(
    id: 5,
    title: 'Song 5',
    artist: 'Artist 5',
    albumArtUrl: song5,
  ),
];
