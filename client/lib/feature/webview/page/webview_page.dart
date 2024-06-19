import 'dart:io';
import 'package:app_gokai/feature/home/view/home_page.dart';
import 'package:app_gokai/feature/webview/package/draggable_expandable_fab.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

late WebViewController _webViewController;

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({super.key, required this.url});

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  ConnectivityResult? _connectivityResult;

  bool _isConnected = true;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      _showNoInternetSnackBar();
    }

    setState(() {
      _connectivityResult = result;
    });

    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          _isConnected = false;
        });
        _showNoInternetSnackBar();
      } else {
        if (!_isConnected) {
          _isConnected = true;
          _showInternetBackSnackBar();
        }
      }
    });
  }

  Future<void> _checkConnectivity() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
    }
  }

  void _showNoInternetSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 3000),
        content: Text('No internet connection'),
        backgroundColor: Colors.black,
      ),
    );
  }

  void _showInternetBackSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 6500),
        content: Text('Internet connection Back'),
        backgroundColor: Colors.black,
        action: SnackBarAction(
          label: 'Reload',
          onPressed: () {
            setState(() {
              _webViewController.reload();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_connectivityResult == null ||
        _connectivityResult == ConnectivityResult.none) {
      return Scaffold(
        body: Center(
          child: Lottie.asset('assets/lottie/nointernet.json'),
        ),
      );
    } else {
      return Scaffold(
        floatingActionButtonLocation: ExpandableFloatLocation(),
        floatingActionButton: floatingactionbuttonutils(context),
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              if (await _webViewController.canGoBack()) {
                _webViewController.goBack();
                return false;
              } else {
                return true;
              }
            },
            child: WebView(
              zoomEnabled: false,
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('tel:')) {
                  launchUrl(Uri.parse(request.url));
                  return NavigationDecision.prevent;
                }
                if (request.url.startsWith('mailto:')) {
                  launchUrl(Uri.parse(request.url));
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
            ),
          ),
        ),
      );
    }
  }

  ExpandableDraggableFab floatingactionbuttonutils(BuildContext context) {
    return ExpandableDraggableFab(
      childrenCount: 2,
      distance: 5,
      childrenType: ChildrenType.columnChildren,
      childrenAlignment: Alignment.centerRight,
      children: [
        IconButton(
          tooltip: 'Close',
          onPressed: () {
            _webViewController.reload();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (b) => HomePage(),
              ),
            );
          },
          icon: Icon(Icons.close),
        ),
        IconButton(
            tooltip: 'Refresh',
            onPressed: () {
              _webViewController.reload();
            },
            icon: Icon(Icons.refresh)),
      ],
    );
  }
}
