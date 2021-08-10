import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/auth/terms_privacy_screen.dart';
import 'package:flutter_auth/components/common.dart';

import 'package:flutter_auth/components/img_color_static_strings.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
            focusNode: nameNode,
            controller: nameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(ageNode);
            },
            decoration:
                custInputDecoration(hintText: "Full Name", context: context),
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 55,
                  child: DropdownButtonFormField(
                    items: ageList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                    onChanged: (selectedAge) {
                      age = selectedAge.toString();
                    },
                    style: TextStyle(fontSize: 13, color: Colors.black),
                    iconEnabledColor: Colors.white,
                    decoration:
                        custInputDecoration(hintText: "Age", context: context),
                    value: age,
                    isExpanded: false,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                    itemHeight: 55,
                    // dropdownColor: Colors.black,
                    // validator: (value) => value.toString().validateState,
                    focusNode: ageNode,
                  ),
                ),
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
                      gender = selectedGender.toString();
                    },
                    style: TextStyle(fontSize: 13, color: Colors.black),
                    iconEnabledColor: Colors.white,
                    decoration: custInputDecoration(
                        hintText: "Gender", context: context),
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
            focusNode: mobileNode,
            controller: mobileController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(emailNode);
            },
            decoration: custInputDecoration(
                hintText: "+91 | Mobile Number", context: context),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            focusNode: emailNode,
            controller: emailController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(cityNode);
            },
            decoration:
                custInputDecoration(hintText: "Email", context: context),
          ),
          SizedBox(
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
                city = selectedCity.toString();
              },
              style: TextStyle(fontSize: 13, color: Colors.black),
              iconEnabledColor: Colors.white,
              decoration:
                  custInputDecoration(hintText: "Gender", context: context),
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
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            focusNode: passwordNode,
            controller: passWordController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(confirmPasswordNode);
            },
            decoration:
                custInputDecoration(hintText: "Password", context: context),
          ),
          SizedBox(
            height: 18,
          ),
          TextFormField(
            focusNode: confirmPasswordNode,
            controller: confirmPasswordController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (val) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            decoration: custInputDecoration(
                hintText: "Confirm Password", context: context),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => TermsAndConditionsScreen(
                                title: "Terms of Service"),
                            fullscreenDialog: true),
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

  Widget buildSignUpButton() {
    return Container(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            custThemeColor,
          ),
        ),
        onPressed: () {},
        child: Text(
          "SIGN UP",
        ),
      ),
    );
  }
}
