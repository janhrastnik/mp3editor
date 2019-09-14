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

  static Future<void> setTitle(filepath, title) async {
    await _channel.invokeMethod('setTitle', <String, dynamic>{
      'filepath': filepath,
      'title': title
    });
  }
}
