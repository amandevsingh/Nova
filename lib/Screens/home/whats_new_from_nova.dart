import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/cust_image.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

import 'package:page_view_indicators/page_view_indicators.dart';

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
    return GestureDetector(
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
                    Image.asset(ImgName.unionAbove, fit: BoxFit.cover),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, right: 15.0, left: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                ImgName.back,
                                width: 16.0,
                                height: 14.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: CustomText(
                                  txtTitle: "What's New From Nova",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          //search field...
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 25.0),
                            child: SizedBox(
                              height: 42.0,
                              child: TextFormField(
                                  controller: searchController,
                                  cursorColor: Colors.white,
                                  cursorHeight: 22.0,
                                  decoration: searchFieldInputDecoration(
                                      context: context,
                                      hintText: "Search Article".toUpperCase()),
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
                Padding(
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
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: CarouselSlider(
                        options: CarouselOptions(
                          scrollPhysics: ClampingScrollPhysics(),
                          height: 205,
                          viewportFraction: 1,
                          aspectRatio: 2.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          onPageChanged: (index, reason) {
                            if (mounted)
                              setState(
                                () {
                                  _currentPageNotifier.value = index;
                                },
                              );
                          },
                        ),
                        items: [
                          carouselItem("", "", ""),
                          carouselItem("", "", ""),
                          carouselItem("", "", "")
                        ]),
                  ),
                ),
                pageIndicators(),
                SizedBox(
                  height: 300.0,
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15.0),
                      itemCount: 10,
                      itemBuilder: (context, i) => detailCard()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailCard() {
    return Padding(
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
                    txtTitle: "What is IVF (in vitro fertilizations) ?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 10.0),
                  ),
                  CustomText(
                    txtTitle:
                        "IVF is the process of fertilizations by\nextracting eggs,",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 10.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: CustomText(
                      txtTitle: "15 May 2021",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Color(0xFF8D8D8D), fontSize: 10.0),
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
    );
  }

  Widget carouselItem(String imagUrl, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustImage(
          imgURL: "",
          assetString: ImgName.doc,
          width: 316,
          height: 123,
          cornerRadius: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: CustomText(
            txtTitle: "When Should You See a Fertility Specialist?",
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: CustomText(
            txtTitle:
                "Infertility is a medical condition that is time-sensitive. Don’t put your fertility journey on hold until the “right time” comes, because when infertility is involved, the right time to act is now.",
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10.0),
            maxLine: 2,
            textOverflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Widget pageIndicators() {
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
        itemCount: 3);
  }
}
