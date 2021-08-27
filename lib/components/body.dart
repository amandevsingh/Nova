import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/auth/auth_setup_screen.dart';
import 'package:flutter_auth/components/custom_enum.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';

import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO EDU",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            // SvgPicture.asset(
            //   "assets/icons/chat.svg",
            //   height: size.height * 0.45,
            // ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, anotherAnimation) {
                      return AuthSetupScreen(
                        authScreenType: AuthScreenType.Login,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 700),
                    transitionsBuilder:
                        (context, animation, anotherAnimation, child) {
                      animation = CurvedAnimation(
                          curve: Curves.easeIn, parent: animation);
                      return Align(
                        child: SlideTransition(
                          position: Tween(
                                  begin: Offset(0.0, -1.0),
                                  end: Offset(0.0, 0.0))
                              .animate(animation),
                          child: child,
                        ),
                      );
                    }));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return AuthSetupScreen(
                //         authScreenType: AuthScreenType.Login,
                //       );
                //     },
                //   ),
                // );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, anotherAnimation) {
                      return AuthSetupScreen(
                        authScreenType: AuthScreenType.SignUp,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 700),
                    transitionsBuilder:
                        (context, animation, anotherAnimation, child) {
                      animation = CurvedAnimation(
                          curve: Curves.easeIn, parent: animation);
                      return Align(
                        child: SlideTransition(
                          position: Tween(
                                  begin: Offset(0.0, 1.0),
                                  end: Offset(0.0, 0.0))
                              .animate(animation),
                          child: child,
                        ),
                      );
                    }));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return AuthSetupScreen(
                //         authScreenType: AuthScreenType.SignUp,
                //       );
                //     },
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
