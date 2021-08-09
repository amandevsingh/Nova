import 'package:flutter/material.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  FocusNode emailNode = FocusNode();

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
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
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
                        .copyWith(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: CustomText(
                txtTitle: "Forgot Password",
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: CustomText(
                align: TextAlign.center,
                txtTitle: "Enter your register email Id or\nmobile number",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: TextFormField(
              focusNode: emailNode,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              decoration: custInputDecoration(
                  context: context,
                  hintText: "Email or Mobile",
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
          Spacer(),
          buildContinueButton()
        ])),
      ),
    );
  }

  Widget buildContinueButton() {
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
