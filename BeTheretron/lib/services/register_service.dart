import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:betherapp/config/config.dart';

class RegisterService {
  Future<void> register(
      String name, String email, String password, String dateOfBirth) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'date_of_birth': dateOfBirth,
      }),
    );

    _handleResponse(response, 'register');
  }

  void _handleResponse(http.Response response, String action) {
    if (response.statusCode != 200) {
      throw Exception('Failed to $action: ${response.reasonPhrase}');
    }
  }
}
