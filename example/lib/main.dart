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
  String title = "";
  String artist = "";
  String album = "";
  String year = "";
  int genre = 0;
  String comment = "";
  String trackNumber = "";
  String filepath;

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

  void setTags() {
    // TODO: setID3v1Tag
    print("setTags gets run");
    print(artist);
    print(title);
    Mp3editor.setID3v1Tag(
        filepath: filepath,
        trackNumber: trackNumber,
        artist: artist,
        title: title,
        album: album,
        year: year,
        genre: genre,
        comment: comment
    );
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
      title = await Mp3editor.getTitle(filepath);
      print("track title is " + title);
    } catch (e) {
      print(e);
    }
    return title;
  }

  Future<String> getArtist() async {
    try {
      artist = await Mp3editor.getArtist(filepath);
      print("artist is " + artist);
    } catch (e) {
      print(e);
    }
    return artist;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(title),
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
                    Text(artist),
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            getArtist();
                          });
                        },
                        child: Text("Get Artist")
                    )
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: title
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a title.";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) => title = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: artist
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter an artist name.";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) => artist = val,
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            setTags();
                          }
                        },
                        child: Text("Submit"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
