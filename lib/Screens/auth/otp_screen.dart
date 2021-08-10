import 'package:flutter/material.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _oneController = TextEditingController();
  TextEditingController _twoController = TextEditingController();
  TextEditingController _threeController = TextEditingController();
  TextEditingController _fourController = TextEditingController();

  @override
  void dispose() {
    _oneController.dispose();
    _twoController.dispose();
    _threeController.dispose();
    _fourController.dispose();
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
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: CustomText(
                        txtTitle: "Back",
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            ?.copyWith(color: Colors.black),
                      ),
                    )
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
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                Center(
                  child: CustomText(
                    align: TextAlign.center,
                    maxLine: 3,
                    txtTitle:
                        "Verify your number with\n4 digit OTP sent to your register\nmobile number",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Colors.black),
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
                                  ?.copyWith(
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
                                  ?.copyWith(
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
                                  ?.copyWith(
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
                                  ?.copyWith(
                                      color: _fourController.text.isNotEmpty
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
                          ?.copyWith(color: Color(0xFFC1C3C4), fontSize: 13.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: CustomText(
                        txtTitle: "Resend",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 13.0),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 200.0,
                ),
                continueButton()
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget continueButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: commonButton(
            context: context,
            btnLabel: "Continue".toUpperCase(),
            onPressed: () {}));
  }

  InputDecoration custInputDecoration(
      {required String hintText, required Color fillColor}) {
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
