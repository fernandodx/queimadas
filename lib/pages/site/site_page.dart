import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queimadas/widgets/app_text_default.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SitePage extends StatefulWidget {
  @override
  _SitePageState createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  WebViewController controller;
  int indexShowWebView;

  @override
  void initState() {
    super.initState();

    indexShowWebView = 1;
    print("isShowProgress: true");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sicoob"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => controller.reload(),
          )
        ],
      ),
      body: getWebview(),
    );
  }

  getWebview() {
    return IndexedStack(
      index: indexShowWebView,
      children: <Widget>[
        WebView(
          initialUrl: "https://www.sicoob.com.br",
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (request) {
            print(request.url);
            return NavigationDecision
                .navigate; //Ou prevent para bloquear a request
          },
          onPageFinished: (val) {
            print("FINISH: $val");
            setState(() {
              indexShowWebView = 0;
            });
          },
        ),
        Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );

  }
}
