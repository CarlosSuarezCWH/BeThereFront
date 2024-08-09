import 'package:flutter/material.dart';
import 'package:betherapp/screens/home_screen.dart';
import 'package:betherapp/screens/search_screen.dart';
import 'package:betherapp/screens/purchase_screen.dart';
import 'package:betherapp/screens/profile_screen.dart';

class MenuSection extends StatefulWidget {
  const MenuSection({super.key});

  @override
  _MenuSectionState createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const PurchaseScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo del Scaffold en negro
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white), // Icono en blanco
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white), // Icono en blanco
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
                color: Colors.white), // Icono en blanco
            label: 'Purchases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white), // Icono en blanco
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        backgroundColor: Colors.black, // Fondo negro del BottomNavigationBar
        selectedItemColor: Colors.white, // Color de los elementos seleccionados
        unselectedItemColor:
            Colors.grey, // Color de los elementos no seleccionados
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
