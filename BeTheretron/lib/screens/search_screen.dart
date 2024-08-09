import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Eventos'),
      ),
      body: Center(
        child: const Text('Aquí podrás buscar entre eventos y subeventos.'),
      ),
    );
  }
}
