import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:betherapp/config/config.dart';
import 'package:betherapp/models/event_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EventService {
  final _storage = const FlutterSecureStorage();

  // Método para obtener eventos populares (actual existente)
  Future<List<Event>> fetchPopularEvents() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/events/'));

    List<Event> events = _handleResponse<List<Event>>(
      response,
      (jsonResponse) =>
          (jsonResponse as List).map((event) => Event.fromJson(event)).toList(),
      'fetch popular events',
    );

    // Imprimir los eventos
    for (var event in events) {
      print(
          'Event ID: ${event.id}, Title: ${event.title}, Price: ${event.price}');
    }

    return events;
  }

  // Nuevo método para obtener eventos destacados
  Future<List<Event>> fetchFeaturedEvents() async {
    final response =
        await http.get(Uri.parse('${ApiConfig.baseUrl}/events/featured'));

    return _handleResponse<List<Event>>(
      response,
      (jsonResponse) =>
          (jsonResponse as List).map((event) => Event.fromJson(event)).toList(),
      'fetch featured events',
    );
  }

  // Nuevo método para obtener eventos próximos
  Future<List<Event>> fetchUpcomingEvents() async {
    final response =
        await http.get(Uri.parse('${ApiConfig.baseUrl}/events/upcoming'));

    return _handleResponse<List<Event>>(
      response,
      (jsonResponse) =>
          (jsonResponse as List).map((event) => Event.fromJson(event)).toList(),
      'fetch upcoming events',
    );
  }

  // Nuevo método para obtener eventos del universo
  Future<List<Event>> fetchUniverseEvents() async {
    final response =
        await http.get(Uri.parse('${ApiConfig.baseUrl}/events/universe'));

    return _handleResponse<List<Event>>(
      response,
      (jsonResponse) =>
          (jsonResponse as List).map((event) => Event.fromJson(event)).toList(),
      'fetch universe events',
    );
  }

  // Método para verificar la compra de subeventos (actual existente)
  Future<bool> checkSubEventPurchase(int userId, int subEventId) async {
    final token = await _storage.read(key: 'auth_token');
    print('Token: $token');
    final response = await http.get(
      Uri.parse(
          '${ApiConfig.baseUrl}/purchases/check_access/$userId/$subEventId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return _handleResponse<bool>(
      response,
      (jsonResponse) => jsonResponse as bool,
      'check subevent purchase',
    );
  }

  // Manejo de la respuesta de la API
  T _handleResponse<T>(
    http.Response response,
    T Function(dynamic) fromJson,
    String action,
  ) {
    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to $action: ${response.reasonPhrase}');
    }
  }
}
