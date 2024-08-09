import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:betherapp/config/config.dart';

class PurchaseService {
  final _storage = const FlutterSecureStorage();

  Future<List<Purchase>> fetchPurchases(int userId) async {
    final token = await _storage.read(key: 'auth_token');

    if (token == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/purchases/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Purchase.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load purchases: ${response.reasonPhrase}');
    }
  }
}

class Purchase {
  final int id;
  final String? status; // Definir como String? para permitir null
  final int userId;
  final int eventId;
  final int? subEventId;

  Purchase({
    required this.id,
    this.status, // Puede ser null
    required this.userId,
    required this.eventId,
    this.subEventId,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      status: json['status'], // Si es null, se asignará como null
      userId: json['user_id'],
      eventId: json['event_id'],
      subEventId: json['subevent_id'],
    );
  }
}
