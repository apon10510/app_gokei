import 'package:app_gokai/advance/app_update_check.dart';
import 'package:app_gokai/advance/rate_app.dart';
import 'package:app_gokai/feature/home/page/app_page.dart';
import 'package:app_gokai/feature/home/page/game_page.dart';
import 'package:app_gokai/feature/setting/pages/setting_page.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _selectedIndex = 0;
  final AppRating appRating = AppRating();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    appRating.rateApp(context);
    verifyVersion(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _getSelectedWidget(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 110,
        color: const Color.fromARGB(255, 221, 239, 241),
        child: FloatingNavbar(
          itemBorderRadius: 15,
          borderRadius: 50,
          elevation: 0,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(
                icon: CupertinoIcons.game_controller, title: 'Game'),
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
        return const AppPage();
      case 1:
        return const GamePage();
      default:
        return const SettingPage();
    }
  }
}
