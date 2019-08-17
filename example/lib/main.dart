import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mp3editor/mp3editor.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String trackTitle;

  @override
  void initState() {
    super.initState();
    getMp3Data();
  }

  Future<void> getMp3Data() async {
    try {
      trackTitle = await Mp3editor.getTitle("Spazzkid_Better_Off_Alone.mp3");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text("Title: " + trackTitle),
            ],
          ),
        ),
      ),
    );
  }
}
