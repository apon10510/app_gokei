import 'package:app_gokai/feature/webview/page/webview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayStoreGridCard extends StatefulWidget {
  final String listName;
  final String appName;
  final String appImage;
  final String apiurl;
  final Function()? iconTap;
  final String appUrl;
  // final Function()? onTap;
  const PlayStoreGridCard({
    super.key,
    required this.listName,
    required this.appName,
    required this.appImage,
    this.iconTap,
    required this.appUrl,
    // this.onTap,
    required this.apiurl,
  });

  @override
  State<PlayStoreGridCard> createState() => _PlayStoreGridCardState();
}

class _PlayStoreGridCardState extends State<PlayStoreGridCard> {
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
    var res =
        await http.get(Uri.parse('https://aponali.github.io/api/allapon.json'));
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
    return SizedBox(
      height: 320,
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 3),
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (b) => WebViewPage(
                  //       url: data[index][widget.appUrl],
                  //     ),
                  //   ),
                  // );
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: WebViewPage(
                        url: data[index][widget.appUrl],
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: 70,
                      width: size.width * 0.16,
                      child: CachedNetworkImage(
                        height: 70,
                        width: size.width * 0.16,
                        imageUrl: data[index][widget.appImage],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.16,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          data[index][widget.appName],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
        ),
      ),
    );
  }
}
