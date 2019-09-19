package janhrastnik.mp3editor;

import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.mpatric.mp3agic.ID3v1;
import com.mpatric.mp3agic.ID3v1Tag;
import com.mpatric.mp3agic.ID3v2;
import com.mpatric.mp3agic.ID3v24Tag;
import com.mpatric.mp3agic.Mp3File;
import com.mpatric.mp3agic.NotSupportedException;
import com.mpatric.mp3agic.UnsupportedTagException;
import com.mpatric.mp3agic.InvalidDataException;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;

/** Mp3editorPlugin */
public class Mp3editorPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "mp3editor");
    channel.setMethodCallHandler(new Mp3editorPlugin());
  }

    public void saveFile(String filepath, Mp3File mp3file) {
        try {
            File file = new File(filepath);
            String newfilepath = filepath.substring(0, filepath.length() - 4) +  " - copy.mp3";
            mp3file.save(newfilepath);
            if (file.delete()) {
                System.out.println("test123");
                System.out.println(newfilepath);
                File oldFile = new File(newfilepath);
                if (oldFile.createNewFile()) {
                    System.out.println("Created new file");
                }
                // File newFileLocation = new File(filepath);
                if (oldFile.renameTo(file)) {
                    System.out.println("File renamed successfully");
                }
            }
        } catch (NotSupportedException NotSupported) {
            System.out.println(NotSupported.toString());
        } catch (IOException IoException) {
            System.out.println(IoException.toString());
        }
    }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    Map<String, Object> arguments = call.arguments();
    String filepath = (String) arguments.get("filepath");
    ID3v1 tag1 = null;
    ID3v2 tag2 = null;

    try {
      Mp3File mp3file = new Mp3File(filepath);

      if (mp3file.hasId3v1Tag()) {
          System.out.println("Mp3file has v1 tag.");
        tag1 = mp3file.getId3v1Tag();
      } else {
          System.out.println("Mp3file has v2 tag.");
        tag2 = mp3file.getId3v2Tag();
      }

      if (call.method.equals("getTitle")) {
        String title;
        if (tag1 != null) {
          title = tag1.getTitle();
        } else {
            System.out.println("v2 tag gets called.");
          title = tag2.getTitle();
        }
        result.success(title);
      } if (call.method.equals("getArtist")) {
            String artist;
            if (tag1 != null) {
                artist = tag1.getArtist();
            } else {
                System.out.println("v2 tag gets called.");
                artist = tag2.getArtist();
            }
            result.success(artist);
      } if (call.method.equals("setID3v1Tags")) {
            ID3v1 id3v1Tag;
            String trackNumber = (String) arguments.get("trackNumber");
            String artist = (String) arguments.get("artist");
            String title = (String) arguments.get("title");
            String album = (String) arguments.get("album");
            String year = (String) arguments.get("year");
            Integer genre = (Integer) arguments.get("genre");
            String comment = (String) arguments.get("comment");

            if (mp3file.hasId3v1Tag()) {
                id3v1Tag =  mp3file.getId3v1Tag();
            } else {
                // mp3 does not have an ID3v1 tag, let's create one..
                id3v1Tag = new ID3v1Tag();
                mp3file.setId3v1Tag(id3v1Tag);
            }
            id3v1Tag.setTrack(trackNumber);
            id3v1Tag.setArtist(artist);
            id3v1Tag.setTitle(title);
            id3v1Tag.setAlbum(album);
            id3v1Tag.setYear(year);
            id3v1Tag.setGenre(genre);
            id3v1Tag.setComment(comment);
            saveFile(filepath, mp3file);
      }

    } catch (IOException Io) {
      System.out.println(Io.toString());
    } catch (UnsupportedTagException UnsupportedTag) {
      System.out.println(UnsupportedTag.toString());
    } catch (InvalidDataException InvalidData) {
      System.out.println(InvalidData.toString());
    }
  }
}

/*
try {
      Mp3File mp3file = new Mp3File(filepath);

      if (mp3file.hasId3v1Tag()) {
        tag1 = mp3file.getId3v1Tag();
      } else {
        tag2 = mp3file.getId3v2Tag();
      }

      if (call.method.equals("getTitle")) {
        String title;
        if (tag1 != null) {
          title = tag1.getTitle();
        } else {
          title = tag2.getTitle();
        }
        result.success(title);
      } if (call.method.equals("setTitle")) {

      } if (call.method.equals("getArtist")) {

      } if (call.method.equals("getArtist")) {

      } else {
        result.notImplemented();
      }

    } catch (IOException Io) {
      result.error(Io.toString(), Io.getMessage(), Io);
    } catch (UnsupportedTagException UnsupportedTag) {
      result.error(UnsupportedTag.toString(), UnsupportedTag.getMessage(), UnsupportedTag);
    } catch (InvalidDataException InvalidData) {
      result.error(InvalidData.toString(), InvalidData.getMessage(), InvalidData);
    }
 */