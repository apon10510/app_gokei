import 'package:app_gokai/core/advance/app_update_check.dart';
import 'package:app_gokai/core/advance/rate_app.dart';
import 'package:app_gokai/feature/home/page/app_page.dart';
import 'package:app_gokai/feature/home/page/game_page.dart';
import 'package:app_gokai/feature/setting/pages/setting_page.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NavigationItem { home, game, settings }

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  NavigationItem _selectedItem = NavigationItem.home;
  final AppRating appRating = AppRating();

  final List<FloatingNavbarItem> _navigationItems = [
    FloatingNavbarItem(icon: Icons.home, title: 'Home'),
    FloatingNavbarItem(icon: CupertinoIcons.game_controller, title: 'Game'),
    FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = NavigationItem.values[index];
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
        child: _getSelectedWidget(_selectedItem),
      ),
      bottomNavigationBar: Container(
        height: 110,
        color: const Color.fromARGB(255, 221, 239, 241),
        child: FloatingNavbar(
          itemBorderRadius: 15,
          borderRadius: 50,
          elevation: 0,
          items: _navigationItems,
          currentIndex: _selectedItem.index,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _getSelectedWidget(NavigationItem item) {
    switch (item) {
      case NavigationItem.home:
        return const AppPage();
      case NavigationItem.game:
        return const GamePage();
      default:
        return const SettingPage();
    }
  }
}

// class AppRatingHandler {
//   static void rateApp(BuildContext context) {
//     // Implement your app rating logic here
//   }
// }

// class AppUpdateCheckHandler {
//   static void verifyVersion(BuildContext context) {
//     // Implement your app update check logic here
//   }
// }
