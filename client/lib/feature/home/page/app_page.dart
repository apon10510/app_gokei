import 'dart:convert';
// import 'package:app_gokai/feature/home/page/game_page.dart';
import 'package:app_gokai/feature/home/page/game_page.dart';
import 'package:app_gokai/feature/home/util/container_search_bar.dart';
import 'package:http/http.dart' as http;
import 'package:app_gokai/feature/home/util/feedback_utils.dart';
import 'package:app_gokai/feature/home/widget/list_card.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  dynamic data;
  Future getData() async {
    var res =
        await http.get(Uri.parse('https://aponali.github.io/api/allapon.json'));
    setState(() {
      var decode = json.decode(res.body).cast<Map<String, dynamic>>();
      data = decode;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 239, 242),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Row(
              children: [
                ContainerSearchBarUtils(),
                IconButton(
                  onPressed: () {
                    feedback(context);
                  },
                  icon: const Icon(Icons.feedback),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(width: 200, child: SigmentedButtonUtils()),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
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

class SigmentedButtonUtils extends StatelessWidget {
  const SigmentedButtonUtils({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: <ButtonSegment<String>>[
        ButtonSegment<String>(
          value: 'Apps',
          label: const Text('Apps'),
        ),
        ButtonSegment<String>(
          value: 'Game',
          label: const Text('Game'),
        ),
      ],
      selected: const <String>{'Apps'},
      onSelectionChanged: (Set<String> newSelection) {
        final String selectedValue = newSelection.first;
        switch (selectedValue) {
          case 'Apps':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppPage(),
              ),
            );
            break;
          case 'Game':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GamePage(),
              ),
            );
            break;
        }
      },
    );
  }
}
