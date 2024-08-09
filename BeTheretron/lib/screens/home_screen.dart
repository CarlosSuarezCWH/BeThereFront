import 'package:flutter/material.dart';
import 'package:betherapp/models/event_model.dart';
import 'package:betherapp/models/category_model.dart';
import 'package:betherapp/services/event_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:betherapp/screens/vr_screen.dart';
import 'package:betherapp/screens/payment_screen.dart';
import 'package:betherapp/services/auth_service.dart';
import 'package:betherapp/widgets/popular_events_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Category>> _categories;
  final EventService _eventService = EventService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _categories = Category.fetchCategories();
  }

  Future<int?> _getUserIdFromToken(String token) async {
    try {
      Map<String, dynamic> payload = JwtDecoder.decode(token);
      return payload['user_id'] as int?;
    } catch (e) {
      debugPrint('Error decoding token: $e');
      return null;
    }
  }

  Future<void> _onEventTap(Event event) async {
    try {
      final token = await _authService.getToken();
      final userId = await _getUserIdFromToken(token!);

      if (userId != null) {
        final hasPurchased =
            await Event.hasUserPurchasedEvent(userId, event.id);

        if (hasPurchased) {
          await event.fetchStreamUrl();
          if (event.streamUrl.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VrVideoScreen(
                  videoUrl: event.streamUrl,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('No se pudo obtener la URL del stream')),
            );
          }
        } else {
          _showPurchaseDialog(event);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error al obtener la información del usuario')),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _showPurchaseDialog(Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Evento no adquirido'),
          content:
              const Text('No has adquirido este evento. ¿Deseas comprarlo?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      eventTitle: event.title, // Pasar el título del evento
                      price: event.price, // Pasar el precio del evento
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final categories = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                PopularEventsSection(
                  categories: categories,
                  onEventTap: _onEventTap,
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text(
              'No events found',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 300,
      color: Colors.blue,
      child: const Center(
        child: Text(
          "Ver en Vivo",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
