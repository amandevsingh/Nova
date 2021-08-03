import 'package:flutter/material.dart';
import 'package:flutter_auth/components/cust_image.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class WhatsNewNovaDetail extends StatefulWidget {
  WhatsNewNovaDetail({Key key}) : super(key: key);

  @override
  _WhatsNewNovaDetailState createState() => _WhatsNewNovaDetailState();
}

class _WhatsNewNovaDetailState extends State<WhatsNewNovaDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //union...
            Image.asset(ImgName.uni, fit: BoxFit.cover),
            //union design...
            Image.asset(ImgName.unionAbove, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  //back button...
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 22.0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  //back label...
                  CustomText(
                    txtTitle: "Back",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, bottom: 15.0, top: 70.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 6.0,
                          color: Color(0xFFD6D6D6))
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustImage(
                        imgURL: "",
                        assetString: ImgName.doc,
                        width: 342,
                        height: 123,
                        cornerRadius: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 20.0, right: 20.0),
                        child: CustomText(
                          txtTitle: "15 May 2021",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Color(0xFF8D8D8D)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Container(
                          height: 1.0,
                          width: 15.0,
                          color: custThemeColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0),
                        child: CustomText(
                          txtTitle:
                              "When Should You See a Fertility Specialist?",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: CustomText(
                          txtTitle:
                              "Infertility is a medical condition that is time-sensitive. Don’t put your fertility journey on hold until the “right time” comes, because when infertility is involved, the right time to act is now.",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0),
                        child: CustomText(
                          txtTitle: "How Long Have You Been Trying?",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: CustomText(
                          txtTitle:
                              "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. meaningful content. Lorem ipsum may be used as a placeholder before final copy is",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0),
                        child: CustomText(
                          txtTitle: "Semen Ejaculate Volume",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: CustomText(
                          txtTitle:
                              "On an average, a man produces 2 – 5 ml volume of semen on ejaculation. If the volume is low or absent, it could be due to the following reasons:",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0),
                        child: CustomText(
                          txtTitle:
                              "1. Failed emission (inability to ejaculate) 2. Incomplete collection (partial collection of the semen) Problems or absence of the duct that carries the spermatozoa. Short abstinence interval (Engaging in sexual intercourse too frequently.)",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
