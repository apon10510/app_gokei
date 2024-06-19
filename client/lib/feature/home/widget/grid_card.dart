import 'package:app_gokai/feature/webview/page/webview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GridCard extends StatefulWidget {
  final String listName;
  final String appName;
  final String appImage;
  final String apiurl;
  final Function()? iconTap;
  final String appUrl;
  final Function()? onTap;
  const GridCard({
    super.key,
    required this.listName,
    required this.appName,
    required this.appImage,
    this.iconTap,
    required this.appUrl,
    // this.onTap,
    required this.apiurl,  this.onTap,
  });

  @override
  State<GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {
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
    return AnimationLimiter(
      child: GridView.builder(
        // scrollDirection: Axis.horizontal,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (b) =>
                            WebViewPage(url: data[index][widget.appUrl])));
                  },
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        height: 85,
                        width: 100,
                        child: CachedNetworkImage(
                          height: 85,
                          width: 100,
                          imageUrl: data[index][widget.appImage],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        // height: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            data[index][widget.appName],
                            // overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14.7,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      ),
    );
  }
}
