import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'dart:convert';

import 'package:redeem/generated/l10n.dart';
import 'package:redeem/theme/colors.dart';

class WebViewRedeem extends StatefulWidget {
  String url;
  WebViewRedeem(this.url);

  @override
  State<WebViewRedeem> createState() => _WebViewRedeemState();
}

class _WebViewRedeemState extends State<WebViewRedeem> {
  double _progrss = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          elevation: 0,
          backgroundColor: CustomColors.primarycolor,
          leading: CustomBackButton(
            onPressed: () {
              Navigator.of(context).pop({
                "back_message_style": "danger",
                "back_message": "",
              });
            },
          )),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            onWebViewCreated: (
              controller,
            ) {
              inAppWebViewController = controller;
            },
            onUpdateVisitedHistory: (controller, url, isReload) {
              String urls = url.toString();
              var query = url?.queryParameters;

              print("query *-*-*-*-*--: $query");
              bool back_to_order = false;
              String back_message = "";
              String back_message_style = "";

              query!.forEach((key, value) {
                if (key == "success_order" && (value == '1' || value == '0')) {
                  back_to_order = true;
                  if (value == '1') {
                    back_message_style = "success";
                  } else {
                    back_message_style = "danger";
                  }
                } else if (key == "success_message") {
                  back_message = value;
                  Codec<String, String> stringToBase64 = utf8.fuse(base64);
                  back_message = stringToBase64.decode(back_message);
                }
              });
              if (back_to_order) {
                Navigator.of(context).pop({
                  "back_message": back_message,
                  "back_message_style": back_message_style,
                });
              }
            },
            onProgressChanged: (controller, progress) {
              setState(() {
                _progrss = progress / 100;
              });
            },
            onCloseWindow: (controller) {
              Navigator.of(context).pop({
                "back_message": S.of(context).Add_Your_Review,
                "back_message_style": "danger",
              });
            },
          ),
          _progrss < 1
              ? LinearProgressIndicator(
                  value: _progrss,
                )
              : Container(
                  height: 0,
                )
        ],
      ),
    );
  }

  _back() {
    Navigator.of(context).pop();
  }
}
