import 'package:app_gokai/feature/home/page/app_page.dart';
import 'package:app_gokai/feature/home/page/game_page.dart';
import 'package:app_version_update/app_version_update.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _verifyVersion();
  }

  void _verifyVersion() async {
    await AppVersionUpdate.checkForUpdates(
      appleId: '284882215',
      playStoreId: 'com.rosa.cosmetics',
    ).then((result) async {
      if (result.canUpdate!) {
        await AppVersionUpdate.showAlertUpdate(
          appVersionResult: result,
          context: context,
          backgroundColor: Colors.grey[200],
          title: 'New version available',
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24.0),
          content: 'Would you like to update your application?',
          contentTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          updateButtonText: 'UPDATE',
          cancelButtonText: 'UPDATE LATER',
        );
      }
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
        color: const Color.fromARGB(255, 221, 239, 241),
        child: FloatingNavbar(
          itemBorderRadius: 15,
          borderRadius: 50,
          elevation: 0,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(
                icon: CupertinoIcons.game_controller, title: 'Game'),
            FloatingNavbarItem(icon: Icons.add, title: 'Chats'),
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
      case 2:
        return const GamePage();
      default:
        return const AppPage();
    }
  }
}
