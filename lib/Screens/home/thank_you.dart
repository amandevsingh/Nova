import 'package:flutter/material.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class ThankYou extends StatelessWidget {
  final bool isCongo;
  const ThankYou({this.isCongo = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //back button...
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Image.asset(
                    ImgName.back,
                    width: 10.0,
                    height: 18.0,
                    color: custThemeColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CustomText(
                        txtTitle: "Back",
                        style: Theme.of(context).textTheme.headline1),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Image.asset(
              ImgName.novaIconWhite,
              height: 52.0,
              width: 150.0,
              color: custThemeColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: CustomText(
              txtTitle: isCongo
                  ? "Congratulations, Your\naccount has been activated!"
                  : "Thank you for\nsigning up.",
              style: Theme.of(context).textTheme.headline3,
              align: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: CustomText(
              txtTitle: isCongo
                  ? "Your account has been activated\ngo to dashboard page."
                  : "We are verifying your details.\naccount activate in 12 hours",
              style: Theme.of(context).textTheme.bodyText1,
              align: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Image.asset(
              isCongo ? ImgName.congo : ImgName.thankyou,
            ),
          ),
          buildChangeButton(context)
        ],
      )),
    );
  }

  Widget buildChangeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Container(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                custThemeColor,
              ),
            ),
            onPressed: () {},
            child: CustomText(
              txtTitle: isCongo ? "Go To dashboard" : "Close".toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            )),
      ),
    );
  }
}
