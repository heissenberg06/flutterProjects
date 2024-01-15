import 'package:bastan2/controllers/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class NewsWebView extends StatefulWidget {
  final String url;
  const NewsWebView({super.key, required this.url});

  @override
  State<NewsWebView> createState() => NewsWebViewState();
}

class NewsWebViewState extends State<NewsWebView> {
  final NewsController newsController = Get.put(NewsController());
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;
  String? firstArticleUrl = NewsController().newsList.isNotEmpty
      ? NewsController().newsList[0].url
      : null;

//shimmer sizer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Stack(
        children: [
          InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
              onWebViewCreated: (InAppWebViewController controller) {
                inAppWebViewController = controller;
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  _progress = _progress / 100;
                });
              })
        ],
      ),
    );
  }
}
