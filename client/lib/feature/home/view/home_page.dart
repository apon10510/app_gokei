import 'package:app_gokai/feature/home/util/search_bar.dart';
import 'package:app_gokai/feature/home/widget/list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          SearchBarUtil(),
          PlatformIconButton(
            onPressed: () {},
            icon: Icon(Icons.feedback),
          ),
        ],
      ),
      body: Column(
        children: [
          ListCard(
            scrollDirection: Axis.horizontal,
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
