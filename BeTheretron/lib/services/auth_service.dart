import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:betherapp/config/config.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': email,
        'password': password,
      }),
    );

    return _handleResponse(response, 'login');
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  String? _handleResponse(http.Response response, String action) {
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['access_token'];
      _storage.write(key: 'auth_token', value: token);
      return null; // No error
    } else {
      return 'Failed to $action: ${response.reasonPhrase}';
    }
  }
}
