import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:mp3editor/mp3editor.dart';
import 'package:flutter/services.dart';
import 'dart:io';

String title = "";
String artist = "";
String album = "";
String year = "";
int genre = 0;
String comment = "";
String trackNumber = "";
String filepath;
String lyrics = "";
String composer = "";
String publisher = "";
String originalArtist = "";
String albumArtist = "";
String copyright = "";
String url = "";
String encoder = "";

void main() => runApp(MyApp());

Future<void> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return new File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

Future<void> getFilepath() async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  if (!(File(dir + "/track.mp3").existsSync())) {
    var bytes = await rootBundle.load("mp3samples/track.mp3");
    await writeToFile(bytes, dir + "/track.mp3");
  }
  filepath = dir + "/track.mp3";
}

Future<dynamic> getValue(Function(dynamic) func) async {
  dynamic value;
  try {
    value = await func(filepath);
  } catch (e) {
    print(e);
  }
  return value;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getFilepath();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
            bottom: TabBar(tabs: [Tab(text: "Id3v1"), Tab(text: "Id3v2")]),
          ),
          body: TabBarView(children: [Id3v1(), Id3v2()]),
        ),
      ),
    );
  }
}

class Id3v1 extends StatefulWidget {
  Id3v1State createState() => Id3v1State();
}

class Id3v1State extends State<Id3v1> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(title != null ? title : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getTitle).then((data) {
                          title = data;
                        });
                      });
                    },
                    child: Text("Get Title"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(artist != null ? artist : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getArtist).then((data) {
                          artist = data;
                        });
                      });
                    },
                    child: Text("Get Artist"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(trackNumber != null ? trackNumber : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getTrackNumber).then((data) {
                          trackNumber = data;
                        });
                      });
                    },
                    child: Text("Get Track Number"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(album != null ? album : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getAlbum).then((data) {
                          album = data;
                        });
                      });
                    },
                    child: Text("Get Album"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(year != null ? year : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getYear).then((data) {
                          year = data;
                        });
                      });
                    },
                    child: Text("Get Year"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(genre.toString() != null ? genre.toString() : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getGenre).then((data) {
                          genre = data;
                        });
                      });
                    },
                    child: Text("Get Genre Number"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(comment != null ? comment : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getComment).then((data) {
                          comment = data;
                        });
                      });
                    },
                    child: Text("Get Comment"))
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
                          hintText: title != null ? title : "empty",
                          labelText: "Title"),
                      onSaved: (val) => title = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: artist != null ? artist : "empty",
                          labelText: "Artist"),
                      onSaved: (val) => artist = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: trackNumber != null ? trackNumber : "empty",
                          labelText: "Track Number"),
                      onSaved: (val) => trackNumber = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: album != null ? album : "empty",
                          labelText: "Album"),
                      onSaved: (val) => album = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: year != null ? year : "empty",
                          labelText: "Year"),
                      onSaved: (val) => year = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: genre.toString() != null
                              ? genre.toString()
                              : "empty",
                          labelText:
                              "Genre number , check online for a list of ID3v1 genres"),
                      validator: (value) {
                        if (int.parse(value) == null) {
                          return "Please enter a number.";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) => genre = int.parse(val),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: comment != null ? comment : "empty",
                          labelText: "Comment"),
                      onSaved: (val) => comment = val,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        Mp3editor.setID3v1Tag(
                            filepath: filepath,
                            trackNumber: trackNumber,
                            title: title,
                            artist: artist,
                            album: album,
                            year: year,
                            genre: genre,
                            comment: comment);
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
    );
  }
}

class Id3v2 extends StatefulWidget {
  Id3v2State createState() => Id3v2State();
}

class Id3v2State extends State<Id3v2> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(title != null ? title : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getTitle).then((data) {
                          title = data;
                        });
                      });
                    },
                    child: Text("Get Title"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(artist != null ? artist : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getArtist).then((data) {
                          artist = data;
                        });
                      });
                    },
                    child: Text("Get Artist"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(trackNumber != null ? trackNumber : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getTrackNumber).then((data) {
                          trackNumber = data;
                        });
                      });
                    },
                    child: Text("Get Track Number"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(album != null ? album : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getAlbum).then((data) {
                          album = data;
                        });
                      });
                    },
                    child: Text("Get Album"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(year != null ? year : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getYear).then((data) {
                          year = data;
                        });
                      });
                    },
                    child: Text("Get Year"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(genre.toString() != null ? genre.toString() : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getGenre).then((data) {
                          genre = data;
                        });
                      });
                    },
                    child: Text("Get Genre Number"))
              ],
            ),
            Row(
              children: <Widget>[
                Text(comment != null ? comment : "empty"),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        getValue(Mp3editor.getComment).then((data) {
                          comment = data;
                        });
                      });
                    },
                    child: Text("Get Comment"))
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
                          hintText: title != null ? title : "empty",
                          labelText: "Title"),
                      onSaved: (val) => title = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: artist != null ? artist : "empty",
                          labelText: "Artist"),
                      onSaved: (val) => artist = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: trackNumber != null ? trackNumber : "empty",
                          labelText: "Track Number"),
                      onSaved: (val) => trackNumber = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: album != null ? album : "empty",
                          labelText: "Album"),
                      onSaved: (val) => album = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: year != null ? year : "empty",
                          labelText: "Year"),
                      onSaved: (val) => year = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: genre.toString() != null
                              ? genre.toString()
                              : "empty",
                          labelText:
                              "Genre number , check online for a list of ID3v1 genres"),
                      validator: (value) {
                        if (int.parse(value) == null) {
                          return "Please enter a number.";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) => genre = int.parse(val),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: comment != null ? comment : "empty",
                          labelText: "Comment"),
                      onSaved: (val) => comment = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: lyrics != null ? lyrics : "empty",
                          labelText: "Lyrics"),
                      onSaved: (val) => lyrics = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: composer != null ? composer : "empty",
                          labelText: "Composer"),
                      onSaved: (val) => composer = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: publisher != null ? publisher : "empty",
                          labelText: "Publisher"),
                      onSaved: (val) => publisher = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText:
                              originalArtist != null ? originalArtist : "empty",
                          labelText: "Original Artist"),
                      onSaved: (val) => originalArtist = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: albumArtist != null ? albumArtist : "empty",
                          labelText: "Album Artist"),
                      onSaved: (val) => albumArtist = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: copyright != null ? copyright : "empty",
                          labelText: "Copyright"),
                      onSaved: (val) => copyright = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: url != null ? url : "empty",
                          labelText: "Url"),
                      onSaved: (val) => url = val,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: encoder != null ? encoder : "empty",
                          labelText: "Encoder"),
                      onSaved: (val) => encoder = val,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        Mp3editor.setID3v2Tag(
                            filepath: filepath,
                            trackNumber: trackNumber,
                            title: title,
                            artist: artist,
                            album: album,
                            year: year,
                            genre: genre,
                            comment: comment,
                            lyrics: lyrics,
                            composer: composer,
                            publisher: publisher,
                            originalArtist: originalArtist,
                            albumArtist: albumArtist,
                            copyright: copyright,
                            url: url,
                            encoder: encoder);
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
    );
  }
}
