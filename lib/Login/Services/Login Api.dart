import 'package:dio/dio.dart';
import 'package:nile_lingo/Constants/Constant.dart';

class LoginApi {
  static final Dio dio = Dio();
  static String loginUrl = "${baseUrl}login";


  static Future<String?> loginUser(String email, String password) async {
    try {
      Response response = await dio.post(
        loginUrl,
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
          validateStatus: (status) {
            return status! < 500; // Allow client errors for better handling
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data["user_id"];
      } else {
        print("❌ Login failed: ${response.data}");
        return null;
      }
    } catch (e) {
      print("🚨 Login Error: $e");
      return null;
    }
  }

}
