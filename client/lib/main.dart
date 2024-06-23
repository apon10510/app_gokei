import 'package:app_gokai/feature/start_page/start_page.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings(); // REMOVE this for release builds
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BetterFeedback(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Gokai',
        home: StartPage(),
      ),
    );
  }
}
