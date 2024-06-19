import 'dart:convert';
import 'package:app_gokai/feature/home/util/search_bar.dart';
import 'package:app_gokai/feature/home/widget/list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart' as http;

dynamic data;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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



  // Future<void> saveData() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   List<String>? saveValue = sharedPreferences.getStringList('AppData');
  //   if (saveValue != null) {
  //     setState(() {
  //       data = saveValue.map((e) => json.decode(e)).toList();
  //     });
  //   }
  // }

  // Future<void> getData() async {
  //   var res =
  //       await http.get(Uri.parse('https://aponali.github.io/api/allapon.json'));
  //   if (res.statusCode == 200) {
  //     var decode = json.decode(res.body) as List;
  //     setState(() {
  //       data = decode;
  //     });
  //     SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();
  //     sharedPreferences.setStringList(
  //         'AppData', decode.map((e) => json.encode(e)).toList());
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   saveData();
  //   getData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          searchBar(context),
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
