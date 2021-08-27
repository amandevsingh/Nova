import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/home_screen.dart';
import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'forgot_password.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obSecureText = true;
  bool _isLoading = false;
  var returnValue;
  var tokens;
  var accesToken;
  UserState userState;
  TextEditingController emailController = TextEditingController();

  TextEditingController passWordController = TextEditingController();

  FocusNode emailNode = FocusNode();

  FocusNode passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return loginBody(context);
  }

  Future<void> doLoad() async {
    var value;
    try {
      value = await Cognito.initialize();
    } catch (e, trace) {
      print(e);
      print(trace);

      if (!mounted) return;
      setState(() {
        returnValue = e;
      });

      return;
    }

    if (!mounted) return;
    setState(() {
      userState = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //  Cognito.registerCallback(null);
    super.dispose();
  }

  Widget loginBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      child: Column(
        children: [
          TextFormField(
            focusNode: emailNode,
            controller: emailController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: custThemeColor),
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(passwordNode);
            },
            decoration: InputDecoration(
                hintText: "Enter Mobile Number",
                prefixText: "+91",
                prefixStyle: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: custThemeColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
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
                    color: Colors.grey,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                )),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: custThemeColor),
            obscureText: obSecureText,
            focusNode: passwordNode,
            controller: passWordController,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
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
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
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
                    color: Colors.grey,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                )),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Hero(
              tag: "fp",
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ForgotPassword(),
                    ),
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          buildLoginButton()
        ],
      ),
    );
  }

  onPressWrapper(fn) {
    wrapper() async {
      SignInResult signInResult;
      String value;
      try {
        signInResult = (await fn()) as SignInResult;
        value = (await fn()).toString();
      } on UserNotConfirmedException catch (e, stacktrace) {
        Cognito.resendSignUp("+91" + emailController.text);
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        // if (mounted)
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => OTPScreen(userName: "+91" + emailController.text),
          ),
        );
        print(e);
      } on NotAuthorizedException catch (e, stacktrace) {
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        //  if (mounted)
        setState(() {
          _isLoading = false;
        });
        Constants.showFlushbarToast("" + e.message, context, 0);
        print(e);
      } catch (e, stacktrace) {
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        // if (mounted)
        setState(() {
          _isLoading = false;
        });
        Constants.showFlushbarToast("" + e.toString(), context, 0);
        print(e);
      }

      if (signInResult != null &&
          signInResult.signInState == SignInState.DONE) {
        try {
          tokens = await Cognito.getTokens();
          accesToken = tokens.idToken;
          returnValue = value;
          var prefs = await SharedPreferences.getInstance();
          await prefs?.setBool(IS_LOGGED_IN, true);
          await prefs?.setString(MOBILE_NUMBER, "+91" + emailController.text);

          await prefs?.setString(USER_TOKEN, "Bearer " + accesToken ?? '');

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => HomeScreen(),
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

  Widget buildLoginButton() {
    return _isLoading
        ? CircularProgressIndicator(
            color: Color(0xff90244c),
          )
        : Container(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  custThemeColor,
                ),
              ),
              onPressed: onPressWrapper(() {
                if (emailController.text.isEmpty) {
                  Constants.showFlushbarToast(
                      "Please enter mobile number.", context, 1);
                } else if (passWordController.text.isEmpty) {
                  Constants.showFlushbarToast(
                      "Please enter password.", context, 1);
                } else {
                  if (mounted)
                    setState(() {
                      _isLoading = true;
                    });
                  // Loader.show(context,
                  //     progressIndicator: CircularProgressIndicator(),
                  //     themeData:
                  //         Theme.of(context).copyWith(accentColor: Color(0xff90244c)));
                  return Cognito.signIn(
                    "+91" + emailController.text,
                    passWordController.text,
                  );
                }
              }),
              /*() {
          Cognito.signIn(
            emailController.text,
            passWordController.text,
          );
          */ /*  Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => HomeScreen(),
            ),
          );
        },*/
              child: Text(
                "SIGN IN",
              ),
            ),
          );
  }
}
