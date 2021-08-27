import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/auth/otp_screen.dart';
import 'package:flutter_auth/Screens/auth/terms_privacy_screen.dart';
import 'package:flutter_auth/common/Constants.dart';

import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import '../home/home_screen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var returnValue;
  UserState userState;
  bool apiHit = false;
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode mobileNode = FocusNode();
  FocusNode ageNode = FocusNode();
  FocusNode genderNode = FocusNode();
  FocusNode cityNode = FocusNode();

  String city = "Select City", age = "Age", gender = "Gender";

  List<String> ageList = ["Age"],
      cityList = ["Select City", "Surat", "Navsari"],
      genderList = ["Gender", "Male", "Female"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List.generate(100, (index) => ageList.add((index + 1).toString()));
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return signUpBody();
  }

  Widget signUpBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      child: Column(
        children: [
          TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: custThemeColor),
            focusNode: nameNode,
            controller: nameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(ageNode);
            },
            decoration: custInputDecoration(hintText: "Full Name"),
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                    height: 55,
                    child: TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: custThemeColor),
                      focusNode: ageNode,
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      maxLength: 2,
                      onFieldSubmitted: (val) {
                        FocusScope.of(context).requestFocus(genderNode);
                      },
                      decoration: custInputDecoration(hintText: "Age"),
                    )),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Container(
                  height: 55,
                  child: DropdownButtonFormField(
                    items: genderList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                    onChanged: (selectedGender) {
                      gender = selectedGender;
                    },
                    style: TextStyle(fontSize: 13, color: Colors.black),
                    iconEnabledColor: Colors.white,
                    decoration: custInputDecoration(hintText: "Gender"),
                    value: gender,
                    isExpanded: false,
                    // isDense: false,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                    itemHeight: 55,
                    // dropdownColor: Colors.black,
                    // validator: (value) => value.toString().validateState,
                    focusNode: genderNode,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: custThemeColor),
            focusNode: mobileNode,
            controller: mobileController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(emailNode);
            },
            decoration:
                custInputDecoration(hintText: " Mobile Number", prefix: "+91"),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: custThemeColor),
            focusNode: emailNode,
            controller: emailController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(passwordNode);
            },
            decoration: custInputDecoration(hintText: "Email"),
          ),
          /* SizedBox(
            height: 18,
          ),
          Container(
            height: 55,
            child: DropdownButtonFormField(
              items: cityList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (selectedCity) {
                city = selectedCity;
              },
              style: TextStyle(fontSize: 13, color: Colors.black),
              iconEnabledColor: Colors.white,
              decoration: custInputDecoration(hintText: "Gender"),
              value: city,
              isExpanded: true,
              isDense: false,
              itemHeight: 55,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              // dropdownColor: Colors.black,
              // validator: (value) => value.toString().validateState,
              focusNode: cityNode,
            ),
          ),*/
          SizedBox(
            height: 18,
          ),
          TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: custThemeColor),
            focusNode: passwordNode,
            controller: passWordController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(confirmPasswordNode);
            },
            decoration: custInputDecoration(hintText: "Password"),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: custThemeColor),
            focusNode: confirmPasswordNode,
            controller: confirmPasswordController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            decoration: custInputDecoration(hintText: "Confirm Password"),
          ),
          SizedBox(
            height: 18,
          ),
          buildSignUpButton(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: "By creating an account you agree to our\n",
                  style: TextStyle(
                    color: Color(0xFFC1C3C4),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "Terms of Service ",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, anotherAnimation) {
                                return TermsAndConditionsScreen(
                                    title: "Terms of Service");
                              },
                              transitionDuration: Duration(milliseconds: 700),
                              transitionsBuilder: (context, animation,
                                  anotherAnimation, child) {
                                animation = CurvedAnimation(
                                    curve: Curves.easeIn, parent: animation);
                                return Align(
                                  child: SizeTransition(
                                    sizeFactor: animation,
                                    child: child,
                                    axisAlignment: 0.0,
                                  ),
                                );
                              })
                          // MaterialPageRoute(
                          //     builder: (context) => TermsAndConditionsScreen(
                          //         title: "Terms of Service"),
                          //     fullscreenDialog: true),
                          );
                    },
                  style: TextStyle(
                    color: custThemeColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "and ",
                  style: TextStyle(
                    color: Color(0xFFC1C3C4),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "Privacy Policy",
                  recognizer: (TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => TermsAndConditionsScreen(
                                title: "Privacy Policy"),
                            fullscreenDialog: true),
                      );
                    }),
                  style: TextStyle(
                    color: custThemeColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration custInputDecoration(
      {@required String hintText, String prefix}) {
    return InputDecoration(
        hintText: hintText,
        prefixText: prefix,
        counterText: "",
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
        ));
  }

  onPressWrapper(fn) {
    wrapper() async {
      SignUpResult signInResult;
      //  String value;
      try {
        //value = (await fn()).toString();
        signInResult = (await fn()) as SignUpResult;
      } on UsernameExistsException catch (e, stacktrace) {
        apiHit = false;
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        // if (mounted)
        setState(() {
          _isLoading = false;
        });
        Constants.showFlushbarToast(
            "Your phone number already exits", context, 0);
        print(e);
      } catch (e, stacktrace) {
        //if (mounted)
        setState(() {
          _isLoading = false;
        });
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        apiHit = false;
        Constants.showFlushbarToast("" + e.toString(), context, 0);
        print(e);
      } finally {
        // if (mounted)
        setState(() {
          _isLoading = false;
        });
        if (mounted)
          setState(() {
            _isLoading = false;
          });
      }

      setState(() => {
            if (signInResult.confirmationState == false)
              {
                apiHit = false,
                //returnValue = value,
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) =>
                        OTPScreen(userName: "+91" + mobileController.text),
                  ),
                ),

                //Loader.hide()
              }
            else
              {
                //Loader.hide(),
                apiHit = false,
                Constants.showFlushbarToast(
                    "Your phone number already exits", context, 0)
              }
          });
    }

    return wrapper;
  }

  Widget buildSignUpButton() {
    return _isLoading
        ? CircularProgressIndicator(
            color: custThemeColor,
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
                if (nameController.text.isEmpty) {
                  Constants.showFlushbarToast(
                      "Please enter a valid Name.", context, 1);
                }
                /*else if (age.isEmpty) {
            Constants.showFlushbarToast("Please select age.", context, 1);
          } else if (gender.isEmpty) {
            Constants.showFlushbarToast("Please select gender.", context, 1);
          }*/
                else if (mobileController.text.isEmpty) {
                  Constants.showFlushbarToast(
                      "Please enter a valid Mobile No.", context, 1);
                } else if (emailController.text.isEmpty) {
                  Constants.showFlushbarToast(
                      "Please enter a valid email.", context, 1);
                } else if (RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(emailController.text) ==
                    false) {
                  Constants.showFlushbarToast(
                      "Please enter valid email id.", context, 1);
                } /* else if (city == "Select City") {
            Constants.showFlushbarToast("Please select city.", context, 1);
          }*/
                else if (passWordController.text.isEmpty) {
                  Constants.showFlushbarToast(
                      "Please enter password.", context, 1);
                } else if (passWordController.text !=
                    confirmPasswordController.text) {
                  Constants.showFlushbarToast(
                      "Password must be same as above.", context, 1);
                } else {
                  if (apiHit == false) {
                    apiHit = true;
                    if (mounted)
                      setState(() {
                        _isLoading = true;
                      });
                    // Loader.show(context,
                    //     progressIndicator: CircularProgressIndicator(),
                    //     themeData: Theme.of(context)
                    //         .copyWith(accentColor: Color(0xff90244c)));

                    Map<String, String> inf = {
                      "name": nameController.text,
                      //   "age": ageController.text,
                      'gender': gender,
                      'phone_number': "+91" + mobileController.text,
                      'email': emailController.text,
                      //'city': city
                    };
                    return Cognito.signUp(
                      "+91" + mobileController.text,
                      passWordController.text,
                      inf.isEmpty ? null : inf,
                    );
                  }
                }
              }),
              child: Text(
                "SIGN UP",
              ),
            ),
          );
  }
}
