class AudioModel {
  final String title;
  final String artist;
  final String path;

  AudioModel({required this.title, required this.artist, required this.path});

  factory AudioModel.fromMap(Map<String, String> map) {
    return AudioModel(
      title: map['title'] ?? 'Unknown Title',
      artist: map['artist'] ?? 'Unknown Artist',
      path: map['path'] ?? '',
    );
  }
}
