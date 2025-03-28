import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PowerBIWebView extends StatefulWidget {
  @override
  _PowerBIWebViewState createState() => _PowerBIWebViewState();
}

class _PowerBIWebViewState extends State<PowerBIWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://app.powerbi.com/reportEmbed?reportId=ef28d063-814f-4c96-8dab-b981b1cfa659&autoAuth=true&ctid=23ed0a78-b844-4659-92fb-a82fff4836b0"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Power BI Report")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
