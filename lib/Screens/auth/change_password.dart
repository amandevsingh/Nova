import 'package:flutter/material.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  FocusNode passwordNode = FocusNode();
  FocusNode newPasswordNode = FocusNode();

  @override
  void dispose() {
    passwordNode.dispose();
    newPasswordNode.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
            child: SingleChildScrollView(
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: CustomText(
                  txtTitle: "Change Password",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: CustomText(
                  txtTitle: "Create a new\npassword",
                  align: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: custThemeColor),
                      focusNode: passwordNode,
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      decoration: custInputDecoration(
                        context: context,
                        hintText: "Password",
                        suffix: Icon(
                          Icons.visibility_outlined,
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: TextFormField(
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: custThemeColor),
                    focusNode: newPasswordNode,
                    controller: newPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    decoration: custInputDecoration(
                      context: context,
                      hintText: "Password",
                      suffix: Icon(
                        Icons.visibility_outlined,
                      ),
                    )),
              ),

              buildChangeButton()
            ],
          ),
        )),
      ),
    );
  }

  Widget buildChangeButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
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
              txtTitle: "Change".toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            )),
      ),
    );
  }
}
