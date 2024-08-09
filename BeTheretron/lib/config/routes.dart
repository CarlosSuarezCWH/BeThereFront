import 'package:flutter/material.dart';
import 'package:betherapp/screens/login_screen.dart';
import 'package:betherapp/widgets/menu_section.dart'; // Importa MenuSection

class Routes {
  static const String login = 'login';
  static const String home = 'home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(
            builder: (_) => const MenuSection()); // MenuSection en home
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
