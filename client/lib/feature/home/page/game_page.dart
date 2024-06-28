import 'dart:convert';
import 'package:app_gokai/feature/home/page/app_page.dart';
import 'package:app_gokai/feature/home/util/app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  dynamic data;
  Future getData() async {
    try {
      var res = await http
          .get(Uri.parse('https://aponali.github.io/api/allapon.json'));
      setState(() {
        var decode = json.decode(res.body).cast<Map<String, dynamic>>();
        data = decode;
      });
    } catch (e) {
      //
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 221, 239, 242),
        actions: const [
          AppBarUtil(),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 221, 239, 242),
      body: const SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Container(width: 200, child: SigmentedButtonUtils()),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SigmentedButtonUtils extends StatefulWidget {
  const SigmentedButtonUtils({
    super.key,
  });

  @override
  State<SigmentedButtonUtils> createState() => _SigmentedButtonUtilsState();
}

class _SigmentedButtonUtilsState extends State<SigmentedButtonUtils> {
  Set<String> selected = {"Apps"};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment<String>(
          value: 'Apps',
          label: Text('Apps'),
        ),
        ButtonSegment<String>(
          value: 'Game',
          label: Text('Game'),
        ),
      ],
      selected: selected,
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
                builder: (context) => const GamePage(),
              ),
            );
            break;
        }
      },
    );
  }
}
