import 'dart:io';

import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayScreen extends StatefulWidget {
  final String link;

  const PayScreen({Key? key, required this.link}) : super(key: key);

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName(AppRoute.home));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 66,
          leading: IconButton(
            icon: Icon(AppIcon.home),
            color: AppColor.rBMain,
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName(AppRoute.home));
            },
          ),
          title: SizedBox(
            width: 195,
            child: Icon(
              AppIcon.logo,
              color: AppColor.rBMain,
              size: 40,
            ),
          ),
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: widget.link,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
