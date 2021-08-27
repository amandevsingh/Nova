import 'package:flutter/material.dart';


class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(child:Text(
          login ? "" : "By creating an account you agree to our \n Terms of Service and Privacy Policy",
          style: TextStyle(color: Color(0xFF821541)),
          textAlign: TextAlign.center,
        )),
        // GestureDetector(
        //   onTap: press,
        //   child: Text(
        //     login ? "Sign Up" : "Sign In",
        //     style: TextStyle(
        //       color: kPrimaryColor,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
