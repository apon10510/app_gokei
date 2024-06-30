import 'package:app_gokai/feature/home/page/game_page.dart';
import 'package:app_gokai/feature/setting/pages/setting_page.dart';
import 'package:app_gokai/feature/start_page/start_page.dart';
import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';

final QuickActions quickActions = const QuickActions();

initializeAction(BuildContext context) {
  quickActions.initialize((String shortvutType) {
    switch (shortvutType) {
      case 'Apps':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (builder) => StartPage()));
        return;
      case 'Game':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (builder) => GamePage()));
        return;
      case 'Setting':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (builder) => SettingPage()));
        return;
      default:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (builder) => StartPage()));
        return;
    }
  });
  quickActions.setShortcutItems(
    [
      ShortcutItem(
        type: 'App',
        localizedTitle: 'App',
      ),
      ShortcutItem(
        type: 'Game',
        localizedTitle: 'Game',
      ),
      ShortcutItem(
        type: 'Setting',
        localizedTitle: 'Setting',
      ),
    ],
  );
}
