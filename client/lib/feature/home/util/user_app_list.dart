import 'package:app_gokai/feature/home/model/app_list_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:app_gokai/feature/webview/page/webview_page.dart';

class UserAppList extends StatefulWidget {
  final AppListModel yourAppsListModel;

  const UserAppList(this.yourAppsListModel, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserAppListState createState() => _UserAppListState();
}

class _UserAppListState extends State<UserAppList> {
  @override
  void initState() {
    super.initState();
    widget.yourAppsListModel.loadAppData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: SizedBox(
        height: 215,
        child: Column(
          children: [
            const SizedBox(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Your App',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                 
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 3),
              child: SizedBox(
                height: 165,
                child: ValueListenableBuilder<List<Map<String, String>>>(
                  valueListenable: widget.yourAppsListModel,
                  builder: (context, yourAppsList, _) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: yourAppsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (b) => WebViewPage(
                                url: yourAppsList[index]['appUrl']!,
                              ),
                            ));
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Remove App'),
                                content: const Text(
                                    'Are you sure you want to remove this app?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      widget.yourAppsListModel.removeApp(index);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Remove'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                height: 115,
                                width: MediaQuery.of(context).size.width * 0.27,
                                child: CachedNetworkImage(
                                  height: 115,
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  imageUrl: yourAppsList[index]['appImage']!,
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.27,
                                height: 45,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: AutoSizeText(
                                    yourAppsList[index]['appName']!,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
