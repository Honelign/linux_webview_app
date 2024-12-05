import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

// import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_linux_webview/flutter_linux_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
  WebView.platform = LinuxWebView();
  WidgetsFlutterBinding.ensureInitialized();
  await LinuxWebViewPlugin.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Youtube',
      debugShowCheckedModeBanner: false,
      home: MyBrowser(),
    );
  }
}

class MyBrowser extends StatefulWidget {
  const MyBrowser({super.key, this.title});
  final String? title;

  @override
  _MyBrowserState createState() => _MyBrowserState();
}

class _MyBrowserState extends State<MyBrowser> with WidgetsBindingObserver {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  /// Prior to Flutter 3.10, comment out the following code since
  /// [WidgetsBindingObserver.didRequestAppExit] does not exist.
  // ===== begin: For Flutter 3.10 or later =====
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<AppExitResponse> didRequestAppExit() async {
    await LinuxWebViewPlugin.terminate();
    return AppExitResponse.exit;
  }
  // ===== end: For Flutter 3.10 or later =====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('flutter_linux_webview example'),
        ),
        body: WebView(
          initialUrl: 'https://www.youtube.com',
          initialCookies: const [
            WebViewCookie(
                name: 'mycookie', value: 'foo', domain: 'www.youtube.com')
          ],
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: const <JavascriptChannel>{},
          navigationDelegate: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          gestureNavigationEnabled: true,
          userAgent:
              'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',
        ));
  }
}
