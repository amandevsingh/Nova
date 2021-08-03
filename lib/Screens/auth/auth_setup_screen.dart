import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/auth/signup.dart';

import 'package:flutter_auth/components/custom_enum.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'login.dart';

class AuthSetupScreen extends StatefulWidget {
  final AuthScreenType authScreenType;
  AuthSetupScreen({Key key, @required this.authScreenType}) : super(key: key);

  @override
  _AuthSetupScreenState createState() => _AuthSetupScreenState();
}

class _AuthSetupScreenState extends State<AuthSetupScreen> {
  AuthScreenType authScreenType = AuthScreenType.Login;
  Size size;

  @override
  void initState() {
    super.initState();

    authScreenType = widget.authScreenType;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 66,
              ),
              Text(
                authScreenType == AuthScreenType.Login ? "Sign In" : "Sign Up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Center(
                child: Text(
                  authScreenType == AuthScreenType.Login
                      ? "Enter your login details to\naccess your account"
                      : "Enter your details to create\nyour account",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 48,
              ),
              buildSignupAndLoginButton(),
              SizedBox(
                height: 28,
              ),
              authScreenType == AuthScreenType.Login
                  ? LoginScreen()
                  : SignupScreen()
            ],
          ),
        ),
      ),
    );
  }

  Container buildSignupAndLoginButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 38),
      height: 55,
      decoration: BoxDecoration(
          color: custThemeColor,
          border: Border.all(
            width: 3,
            color: custThemeColor,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (authScreenType == AuthScreenType.SignUp) {
                    setState(() {
                      authScreenType = AuthScreenType.Login;
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    authScreenType == AuthScreenType.Login
                        ? custThemeColor
                        : Colors.white,
                  ),
                ),
                child: Text(
                  "SIGN IN",
                  style: TextStyle(
                      fontSize: 14,
                      color: authScreenType == AuthScreenType.Login
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (authScreenType == AuthScreenType.Login) {
                    setState(() {
                      authScreenType = AuthScreenType.SignUp;
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    authScreenType == AuthScreenType.SignUp
                        ? custThemeColor
                        : Colors.white,
                  ),
                ),
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                      fontSize: 14,
                      color: authScreenType == AuthScreenType.SignUp
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 110,
      leading: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "Back",
              style: TextStyle(color: Colors.black, fontSize: 18),
            )
          ],
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
