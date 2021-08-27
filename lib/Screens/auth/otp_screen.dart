import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/thank_you.dart';
import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class OTPScreen extends StatefulWidget {
  String userName;
  String password;

  OTPScreen({Key key, this.userName, this.password}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _oneController = TextEditingController();
  TextEditingController _twoController = TextEditingController();
  TextEditingController _threeController = TextEditingController();
  TextEditingController _fourController = TextEditingController();
  TextEditingController _fiveController = TextEditingController();
  TextEditingController _sixController = TextEditingController();
  bool apiHit = false;
 bool _isLoading = false;
  @override
  void dispose() {
    _oneController.dispose();
    _twoController.dispose();
    _threeController.dispose();
    _fourController.dispose();
    _fiveController.dispose();
    _sixController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      ImgName.back,
                      width: 10.0,
                      height: 18.0,
                      color: Colors.black,
                    ),
                    CustomText(
                      txtTitle: "Back",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: CustomText(
                      txtTitle: "otp".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                Center(
                  child: CustomText(
                    align: TextAlign.center,
                    maxLine: 3,
                    txtTitle:
                        "Verify your number with\n6 digit OTP sent to your register\nmobile number",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: FittedBox(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 70.0,
                            width: 70.0,
                            child: TextFormField(
                              controller: _oneController,
                              maxLength: 1,
                              cursorColor: custThemeColor,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: _oneController.text.isNotEmpty
                                          ? Colors.white
                                          : custThemeColor),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: custInputDecoration(
                                hintText: "",
                                fillColor: _oneController.text.isNotEmpty
                                    ? custThemeColor
                                    : Colors.white,
                              ),
                              onChanged: (_) {
                                if (mounted) setState(() {});
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 70.0,
                            width: 70.0,
                            child: TextFormField(
                              controller: _twoController,
                              maxLength: 1,
                              cursorColor: custThemeColor,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: _twoController.text.isNotEmpty
                                          ? Colors.white
                                          : custThemeColor),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: custInputDecoration(
                                hintText: "",
                                fillColor: _twoController.text.isNotEmpty
                                    ? custThemeColor
                                    : Colors.white,
                              ),
                              onChanged: (_) {
                                if (mounted) setState(() {});
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 70.0,
                            width: 70.0,
                            child: TextFormField(
                              controller: _threeController,
                              maxLength: 1,
                              cursorColor: custThemeColor,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: custInputDecoration(
                                hintText: "",
                                fillColor: _threeController.text.isNotEmpty
                                    ? custThemeColor
                                    : Colors.white,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: _threeController.text.isNotEmpty
                                          ? Colors.white
                                          : custThemeColor),
                              onChanged: (_) {
                                if (mounted) setState(() {});
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 70.0,
                            width: 70.0,
                            child: TextFormField(
                              controller: _fourController,
                              maxLength: 1,
                              cursorColor: custThemeColor,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              decoration: custInputDecoration(
                                hintText: "",
                                fillColor: _fourController.text.isNotEmpty
                                    ? custThemeColor
                                    : Colors.white,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: _fourController.text.isNotEmpty
                                          ? Colors.white
                                          : custThemeColor),
                              onChanged: (_) {
                                if (mounted) setState(() {});
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 70.0,
                            width: 70.0,
                            child: TextFormField(
                              controller: _fiveController,
                              maxLength: 1,
                              cursorColor: custThemeColor,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              decoration: custInputDecoration(
                                hintText: "",
                                fillColor: _fiveController.text.isNotEmpty
                                    ? custThemeColor
                                    : Colors.white,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: _fiveController.text.isNotEmpty
                                          ? Colors.white
                                          : custThemeColor),
                              onChanged: (_) {
                                if (mounted) setState(() {});
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 70.0,
                            width: 70.0,
                            child: TextFormField(
                              controller: _sixController,
                              maxLength: 1,
                              cursorColor: custThemeColor,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              decoration: custInputDecoration(
                                hintText: "",
                                fillColor: _sixController.text.isNotEmpty
                                    ? custThemeColor
                                    : Colors.white,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: _sixController.text.isNotEmpty
                                          ? Colors.white
                                          : custThemeColor),
                              onChanged: (_) {
                                if (mounted) setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      txtTitle: "I didn’t receive the code,",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Color(0xFFC1C3C4), fontSize: 13.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: CustomText(
                        txtTitle: "Resend",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 13.0),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 200.0,
                ),
                continueButton(widget)
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget continueButton(OTPScreen widget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child:_isLoading?CircularProgressIndicator(color: custThemeColor,): Container(
        height: 55,
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                custThemeColor,
              ),
            ),
            onPressed: widget.password == null
                ? onPressWrapper(() {
                    String otp = _oneController.text +
                        _twoController.text +
                        _threeController.text +
                        _fourController.text +
                        _fiveController.text +
                        _sixController.text;
                    if (otp.length != 6) {
                      Constants.showFlushbarToast(
                          "Please enter a valid otp.", context, 1);
                    } else {
                      if (apiHit == false) {
                        // Loader.show(context,
                        //     progressIndicator: CircularProgressIndicator(),
                        //     themeData: Theme.of(context)
                        //         .copyWith(accentColor: Color(0xff90244c)));
                        if (mounted)
                          setState(() {
                            _isLoading = true;
                          });

                        apiHit = true;
                        return Cognito.confirmSignUp(
                          widget.userName,
                          otp,
                        );
                      }
                    }
                  })
                : onPressWrapperForgotPassword(() {
                    String otp = _oneController.text +
                        _twoController.text +
                        _threeController.text +
                        _fourController.text +
                        _fiveController.text +
                        _sixController.text;
                    if (otp.length != 6) {
                      Constants.showFlushbarToast(
                          "Please enter a valid otp.", context, 1);
                    } else {
                      if (apiHit == false) {
                        // Loader.show(context,
                        //     progressIndicator: CircularProgressIndicator(),
                        //     themeData: Theme.of(context)
                        //         .copyWith(accentColor: Color(0xff90244c)));
                        if (mounted)
                          setState(() {
                            _isLoading = true;
                          });
                        apiHit = true;
                        return Cognito.confirmForgotPassword(
                          widget.userName,
                          widget.password,
                          otp,
                        );
                      }
                    }
                  }),
            child: CustomText(
              txtTitle: "Continue".toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            )),
      ),
    );
  }

  onPressWrapper(fn) {
    wrapper() async {
      SignUpResult signUpResult;
      try {
        signUpResult = (await fn()) as SignUpResult;
      } on CodeMismatchException catch (e, stacktrace) {
        apiHit = false;
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        Constants.showFlushbarToast("Invalid otp", context, 0);
        print(e);
      } catch (e, stacktrace) {
        apiHit = false;
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        Constants.showFlushbarToast("Invalid otp" + e, context, 0);
        print(e);
      }

      if (signUpResult != null && signUpResult.confirmationState == true) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => ThankYouPage(isCongo: false),
        ));
        if (mounted)
          setState(() {
            _isLoading = false;
          });
      } else {
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        apiHit = false;
        Constants.showFlushbarToast("Invalid otp", context, 0);
      }
    }

    return wrapper;
  }

  onPressWrapperForgotPassword(fn) {
    wrapper() async {
      ForgotPasswordResult signUpResult;
      try {
        signUpResult = (await fn()) as ForgotPasswordResult;
      } on CodeMismatchException catch (e, stacktrace) {
        apiHit = false;
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        Constants.showFlushbarToast("Invalid otp", context, 0);
        print(e);
      } catch (e, stacktrace) {
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        apiHit = false;
        Constants.showFlushbarToast("Invalid otp" + e, context, 0);
        print(e);
      }

      if (signUpResult != null &&
          signUpResult.state == ForgotPasswordState.DONE) {
        Constants.showFlushbarToast("Success", context, 1);
        Timer(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
        if (mounted)
          setState(() {
            _isLoading = false;
          });
      } else {
        apiHit = false;
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        Constants.showFlushbarToast("Invalid otp", context, 0);
      }
    }

    return wrapper;
  }

  InputDecoration custInputDecoration(
      {@required String hintText, @required Color fillColor}) {
    return InputDecoration(
        fillColor: fillColor,
        filled: true,
        counterText: "",
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFFCAA4B6),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFFCAA4B6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: custThemeColor.withOpacity(0.6),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFFCAA4B6),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFFCAA4B6),
          ),
        ));
  }
}
