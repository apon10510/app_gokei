import 'package:app_gokai/feature/home/model/app_list_model.dart';
import 'package:app_gokai/feature/home/util/floating_action_button_utils.dart';
import 'package:app_gokai/feature/home/util/search_bar.dart';
import 'package:app_gokai/feature/home/util/user_app_list.dart';
import 'package:app_gokai/feature/home/widget/list_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppListModel yourAppsListModel;

  @override
  void initState() {
    super.initState();
    yourAppsListModel = AppListModel(
      [
        {
          'appName': "Apon",
          'appImage':
              "https://i.postimg.cc/Mpb9y1S7/98679147-transformed-removebg-preview.png",
          'appUrl': "https://github.com/apon10510",
        }
      ],
    );
    yourAppsListModel.loadAppData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddAppFloatingActionButton(yourAppsListModel),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          const SearchBarUtil(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.feedback),
          ),
        ],
      ),
      body: Column(
        children: [
          UserAppList(yourAppsListModel),
          const ListCard(
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
