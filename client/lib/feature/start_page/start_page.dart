import 'package:app_gokai/feature/home/view/home_page.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _getSelectedWidget(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 110,
        child: FloatingNavbar(
          elevation: 0,
          backgroundColor: Colors.black,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
            FloatingNavbarItem(icon: Icons.chat_bubble_outline, title: 'Chats'),
            FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _getSelectedWidget(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const HomePage();
      case 2:
        return const HomePage();
      default:
        return const HomePage();
    }
  }
}
