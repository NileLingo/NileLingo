import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../../Constants/Constant.dart';

class AudioApi {
  static String translateAndSpeakEndpoint = "translate-and-speak";
  static String speechToSpeechEndpoint = "speech-to-speech";
  static final Dio dio = Dio();

  static Future<Map<String, String>?> translateAndSpeak(String text, String srcLang, String tgtLang) async {
    try {
      Response response = await dio.post(
        "$baseUrl$translateAndSpeakEndpoint",
        data: {
          "text": text,
          "src_lang": srcLang,
          "tgt_lang": tgtLang,
          "user_id": userId,
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
        String? encodedText = response.headers.value("translated-text");
        String translatedText = encodedText != null ? utf8.decode(base64Decode(encodedText)) : "";

        String? translationId = response.headers.value("translation-id") ?? "";

        final Directory tempDir = await getTemporaryDirectory();
        String filePath = "${tempDir.path}/translated_speech.wav";

        File file = File(filePath);
        await file.writeAsBytes(response.data as List<int>, flush: true);

        print("✅ Translated speech saved at: $filePath");
        print("📜 Translated text: $translatedText");
        print("🆔 Translation ID: $translationId");

        return {
          "translationText": translatedText,
          "audioFilePath": filePath,
          "translationId": translationId, // Return translation ID
        };
      } else {
        print("❌ Translation failed: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Error translating speech: $e");
    }

    return null;
  }

  static Future<Map<String, String>?> speechToSpeechTranslation(String filePath, String srcLang, String tgtLang) async {
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
        "user_id": userId,
      });

      Response response = await dio.post(
        "$baseUrl$speechToSpeechEndpoint",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "ngrok-skip-browser-warning": "true",
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        String? base64Translation = response.headers.value("translated-text");
        String translatedText = base64Translation != null ? utf8.decode(base64Decode(base64Translation)) : "";

        String? translationId = response.headers.value("translation-id") ?? ""; // Extract translation ID

        final Directory tempDir = await getTemporaryDirectory();
        String newFilePath = "${tempDir.path}/translated_speech.wav";

        File file = File(newFilePath);
        await file.writeAsBytes(response.data as List<int>, flush: true);

        print("✅ Translated speech saved at: $newFilePath");
        print("📜 Decoded Translation Text: $translatedText");
        print("🆔 Translation ID: $translationId");

        return {
          "audioFilePath": newFilePath,
          "translationText": translatedText,
          "translationId": translationId, // Return translation ID
        };
      } else {
        print("❌ Speech-to-Speech translation failed: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Error in Speech-to-Speech translation: $e");
    }

    return null;
  }
  static Future<bool?> toggleFavorite(String userId, String translationId) async {
    try {
      Response response = await dio.put(
        "${baseUrl}user/$userId/translations/$translationId/toggle-favorite",
        options: Options(
          headers: {
            "ngrok-skip-browser-warning": "true",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("✅ Favorite status updated: ${response.data}");
        return true;
      } else {
        print("❌ Failed to toggle favorite: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Error toggling favorite: $e");
    }

    return null;
  }
}
