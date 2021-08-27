import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/ArticleUrl.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebView extends StatefulWidget {
  String title;
  String articleID;

  CommonWebView({
    Key key,
    this.articleID,
    this.title,
  }) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<CommonWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  num _stackToView = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        child: Scaffold(
            appBar: null,
            body: IndexedStack(
              index: _stackToView,
              children: [
                Column(
                  children: <Widget>[
                    SafeArea(
                      child: Stack(
                        children: [
                          //union...
                          Image.asset(ImgName.uni,
                              fit: BoxFit.cover, width: 700, height: 75),
                          //union design...
                          Row(
                            children: [
                              Image.asset(ImgName.unionAbove,
                                  height: 75.0, width: 50.0, fit: BoxFit.fill),
                              Spacer(),
                              Image.asset(ImgName.unionAboveB,
                                  height: 75.0, width: 60.0, fit: BoxFit.fill),
                            ],
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, right: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Image.asset(
                                        ImgName.back,
                                        width: 16.0,
                                        height: 14.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: CustomText(
                                        txtTitle: widget.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                //search field...
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Query(
                        options: QueryOptions(
                            document: gql(doctorArticleUrl),
                            pollInterval: Duration(minutes: 5),
                            variables: {"article_id": widget.articleID}),
                        builder: (QueryResult result,
                            {VoidCallback refetch, FetchMore fetchMore}) {
                          if (result.data != null) {
                            ArticleUrl articleUrl =
                                ArticleUrl.fromJson(result.data);
                            return Expanded(
                                child: WebView(
                              initialUrl: articleUrl.userArticle.url,
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated:
                                  (WebViewController webViewController) {
                                _controller.complete(webViewController);
                              },
                            ));
                          } else {
                            return SizedBox(
                              height: 200,
                            );
                          }
                        }),
                  ],
                ),
                Container(
                    child: Center(
                  child: CircularProgressIndicator(),
                )),
              ],
            )),
        client: client);
  }
}
