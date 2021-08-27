import 'package:flutter/material.dart';
import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'otp_screen.dart';

class ForgotPassword extends StatefulWidget {
  String userName;

  ForgotPassword({Key key, this.userName}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    emailNode.dispose();
    emailController.dispose();
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
        backgroundColor: Colors.white,
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomText(
                      txtTitle: "Back",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Hero(
                tag: "fp",
                child: CustomText(
                  txtTitle: "Forgot Password",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomText(
                align: TextAlign.center,
                txtTitle: "Enter your register mobile number",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: custThemeColor),
              focusNode: emailNode,
              controller: emailController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              decoration: custInputDecoration(
                  prefix: "+91",
                  context: context,
                  hintText: "Enter Your Mobile Number",
                  suffix: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      ImgName.email,
                      height: 20.0,
                      width: 20.0,
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: custThemeColor),
                focusNode: passwordNode,
                controller: passWordController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(confirmPasswordNode);
                },
                decoration: custInputDecoration(
                    hintText: "New Password", context: context),
              )),
          SizedBox(
            height: 18,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: custThemeColor),
                focusNode: confirmPasswordNode,
                controller: confirmPasswordController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                decoration: custInputDecoration(
                    hintText: "Confirm New Password", context: context),
              )),
          Spacer(),
          buildContinueButton()
        ])),
      ),
    );
  }

  onPressWrapper(fn) {
    wrapper() async {
      setState(() {});

      ForgotPasswordResult signInResult;
      try {
        signInResult = (await fn()) as ForgotPasswordResult;
      } on UserNotConfirmedException catch (e, stacktrace) {
        /*Cognito.resendSignUp("+91" + emailController.text);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => OTPScreen(userName: "+91" + emailController.text),
          ),
        );*/
        Constants.showFlushbarToast("" + e.message, context, 0);
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        print(e);
      } catch (e, stacktrace) {
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        Constants.showFlushbarToast("" + e.toString(), context, 0);
        print(e);
      } finally {}

      if (signInResult.state == ForgotPasswordState.CONFIRMATION_CODE) {
        try {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => OTPScreen(
                  userName: "+91" + emailController.text,
                  password: passWordController.text),
            ),
          );
          if (mounted)
            setState(() {
              _isLoading = false;
            });
        } catch (err) {
          if (mounted)
            setState(() {
              _isLoading = false;
            });
          Constants.showFlushbarToast("" + err.toString(), context, 0);
          print(err);
        }
      }
    }

    return wrapper;
  }

  Widget buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: _isLoading
          ? CircularProgressIndicator(
              color: custThemeColor,
            )
          : Container(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      custThemeColor,
                    ),
                  ),
                  onPressed: onPressWrapper(() {
                    if (mounted)
                      setState(() {
                        _isLoading = true;
                      });
                    // Loader.show(context,
                    //     progressIndicator: CircularProgressIndicator(),
                    //     themeData: Theme.of(context)
                    //         .copyWith(accentColor: Color(0xff90244c)));
                    return Cognito.forgotPassword(
                      "+91" + emailController.text,
                    );
                  }),
                  child: CustomText(
                    txtTitle: "Continue".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.white),
                  )),
            ),
    );
  }
}
