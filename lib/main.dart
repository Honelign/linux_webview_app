import 'package:flutter/material.dart';
import 'package:webview_all/webview_all.dart';

void main() => runApp(const MyApp());

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

class _MyBrowserState extends State<MyBrowser> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            // Look here!
            child: Webview(url: "https://www.wechat.com/en")));
  }
}