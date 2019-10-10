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

  static Future<String> getTrackNumber(filepath) async {
    final String trackNumber = await _channel.invokeMethod('getTrackNumber', <String, dynamic>{
      'filepath': filepath
    });
    return trackNumber;
  }

  static Future<String> getAlbum(filepath) async {
    final String album = await _channel.invokeMethod('getAlbum', <String, dynamic>{
      'filepath': filepath
    });
    return album;
  }

  static Future<String> getYear(filepath) async {
    final String year = await _channel.invokeMethod('getYear', <String, dynamic>{
      'filepath': filepath
    });
    return year;
  }

  static Future<int> getGenre(filepath) async {
    final int genre = await _channel.invokeMethod('getGenre', <String, dynamic>{
      'filepath': filepath
    });
    return genre;
  }

  static Future<String> getComment(filepath) async {
    final String comment = await _channel.invokeMethod('getComment', <String, dynamic>{
      'filepath': filepath
    });
    return comment;
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

  static Future<void> setID3v2Tag({filepath, trackNumber, artist,
    title, album, year, genre, comment, lyrics, composer, publisher,
    originalArtist, albumArtist, copyright, url, encoder}) async {
    await _channel.invokeMethod('setID3v2Tag', <String, dynamic>{
      'filepath': filepath,
      'trackNumber': trackNumber,
      'artist': artist,
      'title': title,
      'album': album,
      'year': year,
      'genre': genre,
      'comment': comment
      'lyrics': lyrics,
      'composer': composer,
      'publisher': publisher,
      'originalArtist': originalArtist,
      'albumArtist': albumArtist,
      'copyright': copyright,
      'url': url,
      'encoder', encoder
    });
  }
}
