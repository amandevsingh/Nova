import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Stack(
          children: [
            //union...
            Image.asset(ImgName.uni, fit: BoxFit.cover),
            //union design...
            Image.asset(ImgName.unionAbove, fit: BoxFit.cover),
            //nitification list...
            ListView.builder(
                padding: EdgeInsets.only(left: 15.0, right: 15, top: 70.0),
                itemCount: 10,
                itemBuilder: (context, i) => notificationCard()),
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
                  //notification label...
                  CustomText(
                    txtTitle: "Notification",
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget notificationCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 83.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 3.0),
                  blurRadius: 6,
                  color: Color(0xFFDBDBDB)),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 1.0,
                width: 15.0,
                color: custThemeColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: CustomText(
                  txtTitle: "15 May 2021",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Color(0xFFC52068), fontSize: 12.0),
                ),
              ),
              CustomText(
                txtTitle: "Patient Status Update: Abhisha Kaur",
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
