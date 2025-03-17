import 'package:dio/dio.dart';

import '../../Constants/Constant.dart';

class HistoryAPI {
  static Dio dio = Dio();

  static Future<List<Map<String, dynamic>>?> getUserTranslations(String userId) async {
    try {
      final response = await dio.get(
        "${baseUrl}user/$userId/translations",
        options: Options(
          headers: {
            "ngrok-skip-browser-warning": "true",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data as Map<String, dynamic>;

        if (responseData.containsKey("translations") && responseData["translations"] is List) {
          return List<Map<String, dynamic>>.from(responseData["translations"]);
        } else {
          print("❌ Invalid response format: Missing 'translations' key.");
          return [];
        }
      } else {
        print("❌ Failed to retrieve translations: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("🚨 Error retrieving translations: $e");
      return [];
    }
  }

}
