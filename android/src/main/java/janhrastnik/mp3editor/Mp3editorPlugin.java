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
import com.mpatric.mp3agic.ID3v2;
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

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    Map<String, Object> arguments = call.arguments();
    String filepath = (String) arguments.get("filepath");
    ID3v1 tag1 = null;
    ID3v2 tag2 = null;

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
            String title = (String) arguments.get("title");
            if (tag1 != null) {
                tag1.setTitle(title);
            } else {
                tag2.setTitle(title);
            }
            try {
                File file = new File(filepath);
                if (file.delete()) {
                    mp3file.save("temp.mp3");
                    File oldFile = new File("temp.mp3");
                    if (oldFile.renameTo(new File(filepath))) {
                        System.out.println("File renamed successfully");
                    }
                }
            } catch (NotSupportedException NotSupported) {
                System.out.println(NotSupported.toString());
            }
      } if (call.method.equals("getArtist")) {

      } if (call.method.equals("getArtist")) {

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