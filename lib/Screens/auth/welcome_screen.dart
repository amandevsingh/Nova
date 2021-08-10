import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/auth/auth_setup_screen.dart';
import 'package:flutter_auth/components/background.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/custom_enum.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO EDU",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SizedBox(height: size.height * 0.05),
            commonButton(
              context: context,
              btnLabel: "LOGIN",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthSetupScreen(
                        authScreenType: AuthScreenType.Login,
                      );
                    },
                  ),
                );
              },
            ),
            commonButton(
              context: context,
              btnLabel: "SIGN UP",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthSetupScreen(
                        authScreenType: AuthScreenType.SignUp,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
