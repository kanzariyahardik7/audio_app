import 'package:flutter/services.dart';

class AudioQuery {
  static const MethodChannel _channel = MethodChannel("audio_query_channel");

  Future<List<Map<String, String>>> getAllAudio() async {
    final List<Object?> result = await _channel.invokeMethod("getAudioFiles");

    return result.map((item) {
      final map = Map<String, String>.from(item as Map);
      return map;
    }).toList();
  }
}
