import 'package:app_gokai/feature/webview/page/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewUtil extends StatelessWidget {
  final Function(WebViewController) onWebViewCreated;
  const WebViewUtil({
    super.key,
    required this.onWebViewCreated,
    required this.widget,
  });

  final WebViewPage widget;

  @override
  Widget build(BuildContext context) {
    return WebView(
      zoomEnabled: false,
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: onWebViewCreated,
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
    );
  }
}
