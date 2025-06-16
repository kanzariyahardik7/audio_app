class LocalAudio {
  final String title;
  final String artist;
  final String path;

  LocalAudio({required this.title, required this.artist, required this.path});

  factory LocalAudio.fromMap(Map<String, String> map) {
    return LocalAudio(
      title: map['title'] ?? 'Unknown Title',
      artist: map['artist'] ?? 'Unknown Artist',
      path: map['path'] ?? '',
    );
  }
}
