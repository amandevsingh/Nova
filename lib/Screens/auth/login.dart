import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/home_screen.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obSecureText = true;

  TextEditingController emailController = TextEditingController();

  TextEditingController passWordController = TextEditingController();

  FocusNode emailNode = FocusNode();

  FocusNode passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return loginBody(context);
  }

  Widget loginBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      child: Column(
        children: [
          TextFormField(
            focusNode: emailNode,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(passwordNode);
            },
            decoration: custInputDecoration(
                hintText: "Email or Mobile", context: context),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            obscureText: obSecureText,
            focusNode: passwordNode,
            controller: passWordController,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            decoration: custInputDecoration(
              hintText: "Password",
              context: context,
              suffix: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: obSecureText
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            ImgName.openEye,
                            height: 20,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            ImgName.closeEye,
                            height: 20,
                          ),
                        ),
                  onTap: () {
                    setState(() {
                      obSecureText = !obSecureText;
                    });
                  }),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          buildLoginButton()
        ],
      ),
    );
  }

  Widget buildLoginButton() {
    return commonButton(
        context: context, btnLabel: "SIGN IN", onPressed: () {});
  }
}
