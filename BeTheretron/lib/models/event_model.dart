import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:betherapp/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Event {
  final int id;
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final String imageUrl;
  String streamUrl;
  final double price;
  final int categoryId;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.imageUrl,
    this.streamUrl = '',
    required this.price,
    required this.categoryId,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: utf8.decode(json['title'].runes.toList()),
      description: utf8.decode(json['description'].runes.toList()),
      startTime: json['start_time'],
      endTime: json['end_time'],
      imageUrl: json['image_url'] ?? '',
      streamUrl: json['stream_url'] ?? '',
      price: json['price'].toDouble(),
      categoryId: json['category_id'],
    );
  }

  Future<void> fetchStreamUrl() async {
    final _storage = const FlutterSecureStorage();
    final token = await _storage.read(key: 'auth_token');
    print('Token: $token');

    if (token == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/events/$id/stream'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      streamUrl = jsonResponse['stream_url'];
      print("Stream URL for event $id: $streamUrl");
    } else {
      print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      throw Exception('Failed to fetch stream URL');
    }
  }

  static Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/events/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load events: ${response.reasonPhrase}');
    }
  }

  static Future<bool> hasUserPurchasedEvent(int userId, int eventId) async {
    final _storage = const FlutterSecureStorage();
    final token = await _storage.read(key: 'auth_token');

    if (token == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/purchases/check_access/$userId/$eventId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as bool;
    } else {
      throw Exception(
          'Failed to check event purchase: ${response.reasonPhrase}');
    }
  }
}
