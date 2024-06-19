// import 'package:app_gokai/feature/home/view/home_page.dart';
// import 'package:app_gokai/feature/webview/page/webview_page.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:search_page/search_page.dart';

// IconButton searchBar(BuildContext context) {
//   return IconButton(
//     onPressed: () {
//       showSearch(
//         context: context,
//         delegate: SearchPage<Map<String, dynamic>>(
//           failure: const Center(
//             child: Text('No App found :('),
//           ),
//           searchLabel: 'Search App',
//           builder: (builder) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 child: Column(
//                   children: [
//                     ListTile(
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (b) => WebViewPage(
//                               url: builder['allurl'].toString(),
//                             ),
//                           ),
//                         );
//                       },
//                       title: Text(builder['allappname'].toString()),
//                       leading: SizedBox(
//                         height: 40,
//                         width: 40,
//                         child: CachedNetworkImage(
//                           imageUrl: builder['allappimage'].toString(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//           filter: (filter) => [
//             filter['allappname'].toString(),
//           ],
//           items: data,
//         ),
//       );
//     },
//     icon: const Icon(Icons.search),
//   );
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_gokai/feature/webview/page/webview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';

class SearchBarUtil extends StatefulWidget {
  const SearchBarUtil({super.key});

  @override
  State<SearchBarUtil> createState() => SsearchBarStateUtil();
}

class SsearchBarStateUtil extends State<SearchBarUtil> {
  dynamic data ;
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
  @override
  Widget build(BuildContext context) {
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
    icon:  Icon(Icons.search),
  );
  }
}