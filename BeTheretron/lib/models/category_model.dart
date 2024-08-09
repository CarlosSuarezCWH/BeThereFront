import 'dart:convert';
import 'package:http/http.dart' as http;
import 'event_model.dart'; // Asegúrate de que la ruta sea correcta
import 'package:betherapp/config/config.dart';

class Category {
  final int id;
  final String name;
  final List<Event> events;

  Category({
    required this.id,
    required this.name,
    required this.events,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var eventsList = json['events'] as List;
    List<Event> events =
        eventsList.map((eventJson) => Event.fromJson(eventJson)).toList();

    return Category(
      id: json['id'],
      name: json['name'],
      events: events,
    );
  }

  static Future<List<Category>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('${ApiConfig.baseUrl}/categories/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((category) => Category.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load categories: ${response.reasonPhrase}');
    }
  }
}
