import 'package:app_gokai/feature/home/util/feedback_utils.dart';
import 'package:app_gokai/feature/home/util/search_bar.dart';
import 'package:app_gokai/feature/home/widget/list_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          const SearchBarUtil(),
          IconButton(
            onPressed: () {
              feedback(context);
            },
            icon: const Icon(Icons.feedback),
          ),
        ],
      ),
      body: Column(
        children: [
          ListCard(
            listName: 'Popular',
            appName: 'allappname',
            appImage: 'allappimage',
            apiurl: 'https://aponali.github.io/api/allapon.json',
            appUrl: 'allurl',
          ),
        ],
      ),
    );
  }
}
