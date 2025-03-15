import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class AudioApi {
  static String baseUrl = "https://173d-34-16-210-105.ngrok-free.app/";
  static String translateSpeechEndpoint = "translate-text";
  static String translateAndSpeakEndpoint = "translate-and-speak";
  static String speechToSpeechEndpoint = "speech-to-speech";
  static final Dio dio = Dio();
  static Future<String?> translateSpeech(String text, String srcLang, String tgtLang) async {
    try {
      Response response = await dio.post(
        "$baseUrl$translateSpeechEndpoint",
        data: {
          "text": text,
          "src_lang": srcLang,
          "tgt_lang": tgtLang
        },
        options: Options(
          headers: {
            "ngrok-skip-browser-warning": "true",
            "Content-Type": "application/json"
          },
        ),
      );

      if (response.statusCode == 200) {
        var responseData = response.data;

        // Extract translated text
        if (responseData != null && responseData.containsKey("translated_text")) {
          return responseData["translated_text"];
        }
      }
      print("Translation failed with status code: ${response.statusCode}");
      return null;
    } catch (e) {
      print("Error translating speech: $e");
      return null;
    }
  }

  static Future<String?> translateAndSpeak(String text, String srcLang, String tgtLang) async {
    try {
      Response response = await dio.post(
        "$baseUrl$translateAndSpeakEndpoint",
        data: {
          "text": text,
          "src_lang": srcLang,
          "tgt_lang": tgtLang
        },
        options: Options(
          headers: {
            "ngrok-skip-browser-warning": "true",
            "Content-Type": "application/json",
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {

        final Directory tempDir = await getTemporaryDirectory();
        String filePath = "${tempDir.path}/translated_speech.wav";

        File file = File(filePath);
        await file.writeAsBytes(response.data as List<int>, flush: true);


        print("✅ Translated speech saved at: $filePath");
        return filePath;
      } else {
        print("❌ Translation failed: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Error translating speech: $e");
    }

    return null;
  }

  static Future<String?> speechToSpeechTranslation(String filePath, String srcLang, String tgtLang) async {
    try {
      File audioFile = File(filePath);
      if (!audioFile.existsSync()) {
        print("❌ File not found at: $filePath");
        return null;
      }

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(audioFile.path, filename: "input_audio.wav"),
        "src_lang": srcLang,
        "tgt_lang": tgtLang,
      });

      Response response = await dio.post(
        "$baseUrl$speechToSpeechEndpoint",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "ngrok-skip-browser-warning": "true", // Bypass ngrok warning
          },
          responseType: ResponseType.bytes, // Expect binary response (audio file)
        ),
      );

      if (response.statusCode == 200) {
        final Directory tempDir = await getTemporaryDirectory();
        String newFilePath = "${tempDir.path}/translated_speech.wav";

        File file = File(newFilePath);
        await file.writeAsBytes(response.data as List<int>, flush: true);

        print("✅ Translated speech saved at: $newFilePath");
        return newFilePath;
      } else {
        print("❌ Speech-to-Speech translation failed: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Error in Speech-to-Speech translation: $e");
    }

    return null;
  }


}
