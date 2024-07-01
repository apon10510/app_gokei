import 'package:app_gokai/feature/full_screen/widgets/grid_card.dart';
import 'package:flutter/material.dart';

class FullPageApplication extends StatelessWidget {
  final String listName;
  final String appName;
  final String appImage;
  final String apiurl;
  final String appUrl;
  const FullPageApplication(
      {super.key,
      required this.listName,
      required this.appName,
      required this.appImage,
      required this.apiurl,
      required this.appUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
      ),
      body: SafeArea(
        child: GridCard(
          listName: listName,
          appName: appName,
          appImage: appImage,
          apiurl: apiurl,
          appUrl: appUrl,
        ),
      ),
    );
  }
}
