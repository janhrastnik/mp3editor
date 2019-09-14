import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:mp3editor/mp3editor.dart';
import 'package:flutter/services.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String trackTitle = "";
  String filepath;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getFilepath();
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  void onPressed() {
    trackTitle = _controller.text;
    Mp3editor.setTitle(filepath, trackTitle);
  }

  Future<void> getFilepath() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    if (!(File(dir + "/track.mp3").existsSync())) {
      var bytes = await rootBundle.load("mp3samples/track.mp3");
      await writeToFile(bytes, dir + "/track.mp3");
    }
    filepath = dir + "/track.mp3";
  }

  Future<String> getTitle() async {
    try {
      trackTitle = await Mp3editor.getTitle(filepath);
      print("tracktitle is " + trackTitle);
    } catch (e) {
      print(e);
    }
    return trackTitle;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset("mp3samples/aaa.png"),
                Row(
                  children: <Widget>[
                    Text(trackTitle),
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            getTitle();
                          });
                        },
                        child: Text("Get Title")
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: trackTitle
                          ),
                          controller: _controller,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: onPressed,
                      child: Text("Set Title"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
