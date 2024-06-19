import 'package:app_gokai/feature/home/view/home_page.dart';
import 'package:app_gokai/feature/webview/page/webview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';

IconButton searchBar(BuildContext context) {
  return IconButton(
    onPressed: () {
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
              child: Container(
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
    icon: const Icon(Icons.search),
  );
}
