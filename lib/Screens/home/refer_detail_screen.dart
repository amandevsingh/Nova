import 'package:flutter/material.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class ReferDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: custThemeColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  // Container(
                  //   height: 265.0,
                  //   width: double.infinity,
                  //   child: Image.asset(ImgName.union, fit: BoxFit.cover),
                  // ),
                   Row(
                                                children: [
                                                  Image.asset(
                                                      ImgName.unionAbove,
                                                      height: 75.0,
                                                      width: 50.0,
                                                      fit: BoxFit.fill),
                                                  Spacer(),
                                                  Image.asset(
                                                      ImgName.unionAboveB,
                                                      height: 75.0,
                                                      width: 60.0,
                                                      fit: BoxFit.fill),
                                                ],
                                              ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 15.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 22.0),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CustomText(
                          txtTitle: "Back",
                          style: Theme.of(context).textTheme.headline1.copyWith(
                              fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  height: 209,
                  width: 260,
                  padding: EdgeInsets.only(right: 40),
                  child: Image.asset(ImgName.docHeart)),
              Container(
                height: 450,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(74),
                    topRight: Radius.circular(74),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      ImgName.check,
                      height: 96,
                      width: 96,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomText(
                        txtTitle: "Thanks for sharing the details.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        align: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomText(
                        txtTitle:
                            "We will keep you updated on the patient's status and interaction with Nova.",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        align: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    closeButton(context),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget closeButton(BuildContext context) {
    return Container(
      height: 40,
      width: 241,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            custThemeColor,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: CustomText(
          txtTitle: "Close",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
