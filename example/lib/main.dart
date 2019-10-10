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

  void setV1Tags() {
    // TODO: setID3v1Tag
    print("setTags gets run");
    print(artist);
    print(title);
    Mp3editor.setID3v1Tag(
        filepath: filepath,
        trackNumber: trackNumber,
        title: title,
        artist: artist,
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

  void getTitle() async {
    try {
      title = await Mp3editor.getTitle(filepath);
    } catch (e) {
      print(e);
    }
  }

  void getArtist() async {
    try {
      artist = await Mp3editor.getArtist(filepath);
    } catch (e) {
      print(e);
    }
  }

  void getTrackNumber() async {
    try {
      trackNumber = await Mp3editor.getTrackNumber(filepath);
    } catch (e) {
      print(e);
    }
  }

  void getAlbum() async {
    try {
      album = await Mp3editor.getAlbum(filepath);
    } catch (e) {
      print(e);
    }
  }

  void getYear() async {
    try {
      year = await Mp3editor.getYear(filepath);
    } catch (e) {
      print(e);
    }
  }

  void getGenre() async {
    try {
      genre = await Mp3editor.getGenre(filepath);
    } catch (e) {
      print(e);
    }
  }

  void getComment() async {
    try {
      comment = await Mp3editor.getComment(filepath);
    } catch (e) {
      print(e);
    }
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
                    Text(title != null ? title : "empty"),
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
                    Text(artist != null ? artist : "empty"),
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
                Row(
                  children: <Widget>[
                    Text(trackNumber != null ? trackNumber : "empty"),
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            getTrackNumber();
                          });
                        },
                        child: Text("Get Track Number")
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(album != null ? album : "empty"),
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            getAlbum();
                          });
                        },
                        child: Text("Get Album")
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(year != null ? year : "empty"),
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            getYear();
                          });
                        },
                        child: Text("Get Year")
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(genre.toString() != null ? genre.toString() : "empty"),
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            getGenre();
                          });
                        },
                        child: Text("Get Genre Number")
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(comment != null ? comment : "empty"),
                    MaterialButton(
                        onPressed: () {
                          setState(() {
                            getComment();
                          });
                        },
                        child: Text("Get Comment")
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
                              hintText: title != null ? title : "empty",
                              labelText: "Title"
                          ),
                          onSaved: (val) => title = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: artist != null ? artist : "empty",
                              labelText: "Artist"
                          ),
                          onSaved: (val) => artist = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: trackNumber != null ? trackNumber : "empty",
                              labelText: "Track Number"
                          ),
                          onSaved: (val) => trackNumber = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: album != null ? album : "empty",
                              labelText: "Album"
                          ),
                          onSaved: (val) => album = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: year != null ? year : "empty",
                              labelText: "Year"
                          ),
                          onSaved: (val) => year = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: genre.toString() != null ? genre.toString() : "empty",
                              labelText: "Genre number , check online for a list of ID3v1 genres"
                          ),
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
                              labelText: "Comment"
                          ),
                          onSaved: (val) => comment = val,
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            setV1Tags();
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
