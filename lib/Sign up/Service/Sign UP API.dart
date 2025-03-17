import 'package:dio/dio.dart';

import '../../Constants/Constant.dart';

import 'dart:convert';
import 'package:dio/dio.dart';

class SignUPApi {
  static String signUp = "${baseUrl}register"; // Ensure baseUrl is defined
  static final Dio dio = Dio();

  static Future<String?> registerUser(String email, String username, String password) async {
    try {
      Response response = await dio.post(
        signUp,
        data: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
        }),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "ngrok-skip-browser-warning": "true",
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        String userId = responseData["user_id"];
        print("✅ User registered successfully. User ID: $userId");
        return userId;
      } else {
        print("❌ Registration failed: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Error during user registration: $e");
    }

    return null;
  }
}
