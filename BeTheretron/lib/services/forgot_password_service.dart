import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:betherapp/config/config.dart';

class ForgotPasswordService {
  Future<void> sendPasswordResetEmail(String email) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/forgot-password'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
      }),
    );

    _handleResponse(response, 'send password reset email');
  }

  void _handleResponse(http.Response response, String action) {
    if (response.statusCode != 200) {
      throw Exception('Failed to $action: ${response.reasonPhrase}');
    }
  }
}
