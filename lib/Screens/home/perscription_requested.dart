import 'package:flutter/material.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class PerscriptionRequested extends StatefulWidget {
  PerscriptionRequested({Key key}) : super(key: key);

  @override
  _PerscriptionRequestedState createState() => _PerscriptionRequestedState();
}

class _PerscriptionRequestedState extends State<PerscriptionRequested> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF80144D),
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [
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
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset(
              ImgName.req,
              width: 195.0,
              height: 205.0,
            ),
          ),
          Spacer(),
          Container(
            height: 385.0,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(172.0),
                    topRight: Radius.circular(172.0))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Image.asset(
                    ImgName.file,
                    height: 100.0,
                    width: 90.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomText(
                    txtTitle: "Prescription Request Submitted".toUpperCase(),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomText(
                    align: TextAlign.center,
                    txtTitle:
                        "Your Request for Prescription of 'Shruti Khanna' has been submitted",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                CustomText(
                  txtTitle: "Our team will contact you shortly.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                Spacer(),
                closeButton()
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget closeButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 40,
        width: 215.0,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                custThemeColor,
              ),
            ),
            onPressed: () {},
            child: CustomText(
              txtTitle: "Close",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            )),
      ),
    );
  }
}
