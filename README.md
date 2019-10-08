# mp3editor

A Flutter plugin for reading and writing mp3 file tags.

## Usage

First get the filepath from an mp3 file saved on the device.
If you have the mp3 file in your flutter assets, you can save it to the device
like so:

'''dart
writeToFile(Future<void> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return new File(path).writeAsBytes(
    buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)
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
'''

To read specific tags:

'''dart
Future<String> title = Mp3editor.getTitle(filepath);
Future<String> artist = Mp3editor.getArtist(filepath);
Future<String> trackNumber = Mp3editor.getTrackNumber(filepath);
Future<String> album = Mp3editor.getAlbum(filepath);
Future<String> year = Mp3editor.getYear(filepath);
Future<String> genre = Mp3editor.getGenre(filepath);
Future<String> comment = Mp3editor.getComment(filepath);
'''

Method will return null if tag is empty.

To write tags, you will need overwrite all the existing tags in the file: 
'''dart
Mp3editor.setID3v1Tag(
  filepath: filepath,
  title: 'Title',
  artist: 'Artist',
  album: 'Album',
  year: '2019',
  genre: 52,
  comment: 'Comment'
);
'''
Be careful with the 'genre' parameter, you need to specify an ID3v1 genre
number, see [this](https://en.wikipedia.org/wiki/List_of_ID3v1_Genres) for more.

Checkout the [example](https://github.com/janhrastnik/mp3editor/blob/master/example/lib/main.dart) for further details.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
