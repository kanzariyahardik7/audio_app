class MusicDetailsModel {
  final int id;
  final String title;
  final String artist;
  final String albumArtUrl; // Changed to URL for external images

  MusicDetailsModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumArtUrl,
  });
}
