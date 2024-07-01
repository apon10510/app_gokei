import 'package:app_gokai/feature/full_screen/pages/app/full_page_application.dart';
import 'package:app_gokai/feature/webview/page/webview_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListCard extends StatefulWidget {
  final String listName;
  final String appName;
  final String appImage;
  final String apiurl;
  // final Function() iconTap;
  final String appUrl;
  const ListCard({
    super.key,
    required this.listName,
    required this.appName,
    required this.appImage,
    // required this.iconTap,
    required this.appUrl,
    required this.apiurl,
  });

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  dynamic data;

  Future<void> saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? saveValue = sharedPreferences.getStringList('AppData');
    if (saveValue != null) {
      setState(() {
        data = saveValue.map((e) => json.decode(e)).toList();
      });
    }
  }

  Future<void> getData() async {
    var res = await http.get(Uri.parse(widget.apiurl));
    if (res.statusCode == 200) {
      var decode = json.decode(res.body) as List;
      setState(() {
        data = decode;
      });
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setStringList(
          'AppData', decode.map((e) => json.encode(e)).toList());
    }
  }

  @override
  void initState() {
    super.initState();
    saveData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: SizedBox(
        height: 215,
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      widget.listName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (builder) => FullPageApplication(
                            listName: widget.listName,
                            appName: widget.appName,
                            appImage: widget.appImage,
                            apiurl: widget.apiurl,
                            appUrl: widget.appUrl,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.navigate_next, size: 40),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (b) => WebViewPage(
                              url: data[index][widget.appUrl],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            height: 115,
                            width: size.width * 0.27,
                            imageUrl: data[index][widget.appImage],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: size.width * 0.27,
                            child: AutoSizeText(
                              data[index][widget.appName],
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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
          ],
        ),
      ),
    );
  }
}
