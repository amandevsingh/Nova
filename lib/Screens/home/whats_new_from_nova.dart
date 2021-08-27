import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/DoctorContentList.dart';
import 'package:flutter_auth/Screens/home/whats_new_from_nova_detail.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/cust_image.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import 'package:page_view_indicators/page_view_indicators.dart';

import 'CommonWebView.dart';

class WhatsNewFromNova extends StatefulWidget {
  WhatsNewFromNova({Key key}) : super(key: key);

  @override
  _WhatsNewFromNovaState createState() => _WhatsNewFromNovaState();
}

class _WhatsNewFromNovaState extends State<WhatsNewFromNova> {
  TextEditingController searchController = TextEditingController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: Color(0xFFF4F4F5),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        //union...
                        Image.asset(ImgName.uni, fit: BoxFit.cover),
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
                              const EdgeInsets.only(top: 10.0, right: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios,
                                        color: Colors.white, size: 22.0),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  CustomText(
                                    txtTitle: "What's New From Nova",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                              //search field...
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0, top: 15.0),
                                child: SizedBox(
                                  height: 42.0,
                                  child: TextFormField(
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(color: custThemeColor),
                                      controller: searchController,
                                      cursorColor: Colors.white,
                                      cursorHeight: 22.0,
                                      decoration: searchFieldInputDecoration(
                                          context: context,
                                          hintText:
                                              "Search Article".toUpperCase()),
                                      onChanged: (_) {
                                        if (mounted) setState(() {});
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Query(
                        options: QueryOptions(
                            document: gql(doctorContent),
                            pollInterval: Duration(minutes: 5)),
                        builder: (QueryResult result,
                            {VoidCallback refetch, FetchMore fetchMore}) {
                          List<DataUserContent> dataUserContentSearch = List();
                          if (result.data != null) {
                            DoctorContentList doctorContentList =
                                DoctorContentList.fromJson(result.data);
                            if (searchController.text.isEmpty) {
                              dataUserContentSearch
                                  .addAll(doctorContentList.dataUserContent);
                            } else {
                              dataUserContentSearch = doctorContentList
                                  .dataUserContent
                                  .where((element) => element.title
                                      .toLowerCase()
                                      .contains(
                                          searchController.text.toLowerCase()))
                                  .toList();
                            }
                            return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Visibility(
                                    visible: searchController.text.isEmpty,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 20.0),
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        height: 205.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(0, 3),
                                                  blurRadius: 6.0,
                                                  color: Color(0xFFD6D6D6))
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        child: CarouselSlider(
                                            options: CarouselOptions(
                                              scrollPhysics:
                                                  ClampingScrollPhysics(),
                                              height: 205,
                                              viewportFraction: 1,
                                              aspectRatio: 2.0,
                                              autoPlay: true,
                                              autoPlayInterval:
                                                  Duration(seconds: 3),
                                              onPageChanged: (index, reason) {
                                                if (mounted)
                                                  setState(
                                                    () {
                                                      _currentPageNotifier
                                                          .value = index;
                                                    },
                                                  );
                                              },
                                            ),
                                            items: doctorContentList
                                                .dataUserContent
                                                .map((it) {
                                              return carouselItem(
                                                  doctorContentList
                                                          .dataUserContent[
                                                      _currentPageNotifier
                                                          .value]);
                                            }).toList()),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      visible: searchController.text.isEmpty,
                                      child: pageIndicators(doctorContentList
                                                  .dataUserContent.length >
                                              3
                                          ? 3
                                          : doctorContentList
                                              .dataUserContent.length)),
                                  SizedBox(
                                    height: 300.0,
                                    child: ListView.builder(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 15.0),
                                        itemCount: dataUserContentSearch.length,
                                        itemBuilder: (context, i) => detailCard(
                                            dataUserContentSearch[i])),
                                  )
                                ]);
                          } else {
                            return SizedBox(
                              height: 200,
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
        client: client);
  }

  Widget detailCard(DataUserContent dataUserContent) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return CommonWebView(
                        articleID: dataUserContent.id,
                        title: dataUserContent.title);
                  },
                  transitionDuration: Duration(milliseconds: 700),
                  transitionsBuilder:
                      (context, animation, anotherAnimation, child) {
                    animation = CurvedAnimation(
                        curve: Curves.easeIn, parent: animation);
                    return Align(
                      child: SlideTransition(
                        position: Tween(
                                begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                        child: child,
                      ),
                    );
                  })
              // MaterialPageRoute(
              //   builder: (BuildContext context) => CommonWebView(
              //       articleID: dataUserContent.id,
              //       title: dataUserContent.title))
              );
        }, // Handle your callback
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: 90.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0.0, 3.0),
                      blurRadius: 6,
                      color: Color(0xFFDBDBDB)),
                ]),
            child: Row(
              children: [
                Container(
                    height: 90.0,
                    child: CustImage(
                      imgURL: dataUserContent.imgUrl,
                      height: 90.0,
                      width: 90.0,
                      assetString: ImgName.doc,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        txtTitle: dataUserContent.title,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 10.0),
                      ),
                      CustomText(
                        txtTitle: dataUserContent.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 10.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: CustomText(
                          txtTitle: isTest(dataUserContent.createdAt),
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Color(0xFF8D8D8D), fontSize: 10.0),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        width: 15.0,
                        color: custThemeColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String isTest(String value) {
    if (value.isNotEmpty) {
      var parts = value.split('T');
      var prefix = parts[0].trim();
      var inputDate = DateFormat('yyyy-MM-dd').parse(prefix);
      var outputFormat = DateFormat('dd-MMM-yyyy');
      return outputFormat.format(inputDate);
    } else {
      return "";
    }
  }

  Widget carouselItem(DataUserContent dataUserContent) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return CommonWebView(
                        articleID: dataUserContent.id,
                        title: dataUserContent.title);
                  },
                  transitionDuration: Duration(milliseconds: 700),
                  transitionsBuilder:
                      (context, animation, anotherAnimation, child) {
                    animation = CurvedAnimation(
                        curve: Curves.easeIn, parent: animation);
                    return Align(
                      child: SlideTransition(
                        position: Tween(
                                begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                        child: child,
                      ),
                    );
                  })
              // MaterialPageRoute(
              //   builder: (BuildContext context) => CommonWebView(
              //       articleID: dataUserContent.id,
              //       title: dataUserContent.title))
              );
        }, // Handle your callback
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustImage(
              imgURL: dataUserContent.imgUrl,
              assetString: ImgName.doc,
              width: 316,
              height: 123,
              cornerRadius: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: CustomText(
                txtTitle: dataUserContent.title,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: CustomText(
                txtTitle: dataUserContent.description,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(fontSize: 10.0),
                maxLine: 2,
                textOverflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ));
  }

  Widget pageIndicators(int length) {
    return CirclePageIndicator(
        size: 4.0,
        selectedSize: 4.0,
        dotSpacing: 4.0,
        dotColor: Color(0xFFC4C4C4),
        selectedDotColor: Color(0xFF000000),
        borderColor: Color(0xFFBDBDBD),
        borderWidth: 0.0,
        selectedBorderColor: Color(0xFF61948E),
        currentPageNotifier: _currentPageNotifier,
        itemCount: length);
  }
}
