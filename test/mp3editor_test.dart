import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp3editor/mp3editor.dart';

void main() {
  const MethodChannel channel = MethodChannel('mp3editor');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Mp3editor.platformVersion, '42');
  });
}
