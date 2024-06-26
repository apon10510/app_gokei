import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_gokai/feature/home/util/search_bar.dart';
import 'package:app_gokai/feature/webview/page/webview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';

class ContainerSearchBarUtils extends StatefulWidget {
  const ContainerSearchBarUtils({super.key});

  @override
  State<ContainerSearchBarUtils> createState() =>
      _ContainerSearchBarUtilsState();
}

class _ContainerSearchBarUtilsState extends State<ContainerSearchBarUtils> {
  dynamic data;
  Future getData() async {
    var res =
        await http.get(Uri.parse('https://aponali.github.io/api/allapon.json'));
    try {
      setState(() {
        var decode = json.decode(res.body).cast<Map<String, dynamic>>();
        data = decode;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: SearchPage<Map<String, dynamic>>(
            failure: const Center(
              child: Text('No App found :('),
            ),
            searchLabel: 'Search App',
            builder: (builder) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (b) => WebViewPage(
                              url: builder['allurl'].toString(),
                            ),
                          ),
                        );
                      },
                      title: Text(builder['allappname'].toString()),
                      leading: SizedBox(
                        height: 40,
                        width: 40,
                        child: CachedNetworkImage(
                          imageUrl: builder['allappimage'].toString(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            filter: (filter) => [
              filter['allappname'].toString(),
            ],
            items: data,
          ),
        );
      },
      child: Container(
        height: 40,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Search Here',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            const IconSearchBarUtil(),
          ],
        ),
      ),
    );
  }
}
