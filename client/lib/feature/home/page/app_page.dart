import 'package:app_gokai/feature/home/page/game_page.dart';
import 'package:app_gokai/feature/home/util/app_bar.dart';
import 'package:app_gokai/feature/home/widget/list_card.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 239, 242),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 221, 239, 242),
        actions: const [
          AppBarUtil(),
        ],
      ),
      body: SafeArea(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 200, child: SigmentedButtonUtils()),
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
            ListCard(
              listName: 'Edit',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://apon10510.github.io/api/country.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Media',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://aponali.github.io/api/allapon.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Coding',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://apon10510.github.io/api/country.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Woman',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://aponali.github.io/api/allapon.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Male',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://apon10510.github.io/api/country.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Review',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://aponali.github.io/api/allapon.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Most Usefull',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://apon10510.github.io/api/country.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Social Media',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://aponali.github.io/api/allapon.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Tv Channel',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://apon10510.github.io/api/country.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Everything',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://aponali.github.io/api/allapon.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Popular',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://apon10510.github.io/api/country.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Popular',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://aponali.github.io/api/allapon.json',
              appUrl: 'allurl',
            ),
            ListCard(
              listName: 'Popular',
              appName: 'allappname',
              appImage: 'allappimage',
              apiurl: 'https://apon10510.github.io/api/country.json',
              appUrl: 'allurl',
            ),
          ],
        ),
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
      segments: const <ButtonSegment<String>>[
        ButtonSegment<String>(
          value: 'Apps',
          label: Text('Apps'),
        ),
        ButtonSegment<String>(
          value: 'Game',
          label: Text('Game'),
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
                builder: (context) => const GamePage(),
              ),
            );
            break;
        }
      },
    );
  }
}
