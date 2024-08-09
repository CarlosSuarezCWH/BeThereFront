import 'package:flutter/material.dart';
import 'package:betherapp/services/purchase_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:betherapp/services/auth_service.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  late Future<List<Purchase>> _purchases =
      Future.value([]); // Inicializar con un valor vacío
  final PurchaseService _purchaseService = PurchaseService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _fetchPurchases();
  }

  Future<void> _fetchPurchases() async {
    final token = await _authService.getToken();
    final userId = await _getUserIdFromToken(token!);

    if (userId != null) {
      setState(() {
        _purchases = _purchaseService.fetchPurchases(userId);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error al obtener la información del usuario')),
      );
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('My Purchases'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Purchase>>(
        future: _purchases,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.white)));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return _buildPurchaseList(snapshot.data!);
          } else {
            return const Center(
              child: Text(
                'No purchases found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildPurchaseList(List<Purchase> purchases) {
    return ListView.builder(
      itemCount: purchases.length,
      itemBuilder: (context, index) {
        final purchase = purchases[index];
        return Card(
          color: Colors.grey[850],
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text('Event ID: ${purchase.eventId}',
                style: TextStyle(color: Colors.white)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (purchase.subEventId != null)
                  Text('Subevent ID: ${purchase.subEventId}',
                      style: TextStyle(color: Colors.white70)),
                Text('Status: ${purchase.status}',
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Implementar la navegación o acciones relacionadas con la compra
            },
          ),
        );
      },
    );
  }
}
