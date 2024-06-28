import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  final String settingText;
  final Function()? onTap;
  const SettingCard({
    super.key,
    required this.settingText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 90,
        width: MediaQuery.of(context).size.width * .95,
        child: Card(
          child: Center(
            child: ListTile(
              title: Text(
                settingText,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
          ),
        ),
      ),
    );
  }
}
