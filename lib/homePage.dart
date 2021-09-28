import 'package:flutter/material.dart';
import 'package:ak_bean_bags/no_internet.dart';
import 'package:provider/provider.dart';
import 'connectivity_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }


  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return model.isOnline
            ?

        WillPopScope(
          onWillPop: () async {
            dynamic url = await controller.currentUrl();
            if (url == "http://www.akbeanbags.in/") {
              return true;
            } else {
              controller.goBack();
              return false;
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: WebView(
                initialUrl: "http://www.akbeanbags.in/",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController wc) {
                  controller = wc;
                  controller.evaluateJavascript(
                      "document.getElementsByClassName('whatsappWidget')[0].style.display='none'");
                },
              ),
            ),
          ),
        ) : NoInternet();
    }
    return Container(
    child: Center(
    child: CircularProgressIndicator(),
    ),
    );
    },
    ),
    );
  }
}

