import 'dart:async';

import 'package:flutter/services.dart';

class Mp3editor {
  static const MethodChannel _channel =
      const MethodChannel('mp3editor');

  static Future<String> getTitle(filepath) async {
    final String title = await _channel.invokeMethod('getTitle', <String, dynamic>{
      'filepath': filepath
    });
    return title;
  }

  static Future<String> getArtist(filepath) async {
    final String title = await _channel.invokeMethod('getArtist', <String, dynamic>{
      'filepath': filepath
    });
    return title;
  }

  static Future<void> setID3v1Tag({filepath, trackNumber, artist,
    title, album, year, genre, comment}) async {
    await _channel.invokeMethod('setID3v1Tag', <String, dynamic>{
      'filepath': filepath,
      'trackNumber': trackNumber,
      'artist': artist,
      'title': title,
      'album': album,
      'year': year,
      'genre': genre,
      'comment': comment
    });
  }
}
