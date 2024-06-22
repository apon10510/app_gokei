import 'dart:io';
import 'package:app_gokai/feature/home/page/app_page.dart';
import 'package:app_gokai/feature/webview/package/draggable_expandable_fab.dart';
import 'package:app_gokai/feature/webview/utils/floating_action_button_utils.dart';
import 'package:app_gokai/feature/webview/utils/webview_util.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({super.key, required this.url});

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  ConnectivityResult? _connectivityResult;
  bool _isConnected = true;
  late WebViewController _webViewController;

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
      const SnackBar(
        duration: Duration(milliseconds: 3000),
        content: Text('No internet connection'),
        backgroundColor: Colors.black,
      ),
    );
  }

  void _showInternetBackSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 5000),
        content: const Text('Internet connection Back'),
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
        floatingActionButton: FloatingActionButtonUtils(
          onReload1: () {
            _webViewController.reload();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (b) => const AppPage(),
              ),
            );
          },
          onReload2: () {
            _webViewController.reload();
          },
        ),
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
            child: WebViewUtil(
              widget: widget,
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
            ),
          ),
        ),
      );
    }
  }
}
