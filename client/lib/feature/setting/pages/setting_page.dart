import 'package:app_gokai/feature/setting/pages/apps_missing_add_page.dart';
import 'package:app_gokai/feature/setting/widget/setting_card_widget.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 239, 242),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 221, 239, 242),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SettingCard(
                settingText: 'Any Apps Missing',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => const AppsMissingAddPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
