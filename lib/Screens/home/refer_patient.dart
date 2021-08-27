import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/UserDetails.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'refer_detail_screen.dart';

class ReferPatientScreen extends StatefulWidget {
  UserDetails userDetails;

  ReferPatientScreen({Key key, this.userDetails}) : super(key: key);

  @override
  _ReferPatientScreenState createState() => _ReferPatientScreenState();
}

class _ReferPatientScreenState extends State<ReferPatientScreen> {
  String age = "Age";
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  List<String> ageList = ["Age"];
  UserCities userCities;
  String gender = "Gender";
  bool _isLoading = false;

  List<String> genderList = ["Gender", "Male", "Female"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserCities userCitiess = UserCities();
    City citys = City();
    citys.city = "Select City";
    userCitiess.city = citys;
    userCities = userCitiess;
    widget.userDetails?.orgUsers[0]?.userCities?.insert(0, userCitiess);
    List.generate(100, (index) => ageList.add((index + 1).toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F5),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _buildTopImagePortion(), // Image , Back button and Icon
              Container(
                color: custThemeColor,
                height: 46,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "REFER A PATIENT",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    titleAndField(
                        textEditingController: nameController,
                        title: "Name",
                        hintText: "Name",
                        textinputType: TextInputType.text,
                        iconData: Icons.contact_phone),
                    Row(
                      children: [
                        Expanded(
                          child: titleAndField(
                              title: "Age",
                              hintText: "Age",
                              textinputType: TextInputType.number,
                              maxLength: 2,
                              textEditingController: ageController),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            height: 65,
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
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                              iconEnabledColor: Colors.white,
                              decoration: commonInputDecoration(
                                  hintText: "Gender", showPostfixIcon: false),
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
                            ),
                          ),
                        ),
                      ],
                    ),
                    titleAndField(
                        textEditingController: mobileController,
                        title: "Mobile No.",
                        maxLength: 15,
                        hintText: " Mobile Number",
                        iconData: Icons.phone,
                        textinputType: TextInputType.number,
                        prefix: "+91"),
                    titleAndField(
                      title: "Email",
                      hintText: "Email",
                      textinputType: TextInputType.emailAddress,
                      textEditingController: emailController,
                      /*child: Container(
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
                            age = selectedAge;
                          },
                          style: TextStyle(fontSize: 13, color: Colors.black),
                          iconEnabledColor: Colors.white,
                          decoration: commonInputDecoration(
                              hintText: "", showPostfixIcon: false),
                          value: age,
                          isExpanded: false,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          hint: Text(
                            "Age",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFAEADAD)),
                          ),
                          itemHeight: 55,
                          // dropdownColor: Colors.black,
                          // validator: (value) => value.toString().validateState,
                          // focusNode: ageNode,
                        ),
                      ),*/
                    ),
                    titleAndField(
                      title: "City",
                      hintText: "City",
                      textinputType: TextInputType.text,
                      child: Container(
                        height: 55,
                        child: DropdownButtonFormField(
                          items: widget.userDetails?.orgUsers[0].userCities
                              .map((UserCities value) {
                            return DropdownMenuItem<UserCities>(
                              value: value,
                              child: Text(
                                value.city.city,
                              ),
                            );
                          }).toList(),
                          onChanged: (selectedCity) {
                            userCities = selectedCity;
                          },
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                          iconEnabledColor: Colors.white,
                          decoration: commonInputDecoration(
                              hintText: "City", showPostfixIcon: false),
                          value: (widget
                                  .userDetails?.orgUsers[0].userCities.isEmpty
                              ? userCities
                              : widget.userDetails?.orgUsers[0].userCities
                                  .firstWhere((item) =>
                                      item.city.city == userCities.city.city)),
                          isExpanded: true,
                          isDense: false,

                          itemHeight: 55,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          // dropdownColor: Colors.black,
                          // validator: (value) => value.toString().validateState,
                          // focusNode: cityNode,
                        ),
                      ),
                    ),
                    titleAndField(
                        textEditingController: remarksController,
                        title: "Reason for Referral",
                        hintText: "Write here...",
                        textinputType: TextInputType.text,
                        maxLength: 250),
                    buildSubmitRefferalNovaButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Image , Back button and Icon
  Widget _buildTopImagePortion() {
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          color: Colors.green,
          child: Image.asset(
            ImgName.doc,
            fit: BoxFit.cover,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Image.asset(
                  ImgName.back,
                  color: Colors.white,
                  height: 20,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                ImgName.logo,
                height: 60,
                width: 60,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget titleAndField(
      {TextEditingController textEditingController,
      @required String title,
      @required String hintText,
      Widget child,
      int minLines = 1,
      TextInputType textinputType,
      int maxLength = 100000,
      IconData iconData,
      String prefix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        SizedBox(
          height: 8,
        ),
        child != null
            ? child
            : Container(
                height: 55,
                child: TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: custThemeColor),
                  // obscureText: obSecureText,
                  // focusNode: passwordNode,
                  controller: textEditingController,
                  minLines: minLines,
                  maxLength: maxLength,

                  keyboardType: textinputType,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (val) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  decoration: commonInputDecoration(
                      hintText: hintText, iconData: iconData, prefix: prefix),
                ),
              ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  InputDecoration commonInputDecoration(
      {String hintText,
      bool showPostfixIcon = true,
      IconData iconData,
      String prefix}) {
    return InputDecoration(
        suffixIcon: showPostfixIcon
            ? GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(iconData),
                ),
              )
            : null,
        hintText: hintText,
        prefixText: prefix,
        counterText: "",
        hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFFAEADAD)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFFBF8CA4),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFFBF8CA4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFFBF8CA4),
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
            color: Color(0xFFBF8CA4),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xFFBF8CA4),
          ),
        ));
  }

  Widget buildSubmitRefferalNovaButton() {
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
              onPressed: () async {
                if (userCities.city.id == null || userCities.city.id.isEmpty) {
                  Constants.showFlushbarToast(
                      "Please select city.", context, 1);
                } else {
                  // Loader.show(context,
                  //     progressIndicator: CircularProgressIndicator(),
                  //     themeData:
                  //         Theme.of(context).copyWith(accentColor: Color(0xff90244c)));
                  if (mounted)
                    setState(() {
                      _isLoading = true;
                    });
                  var prefs = await SharedPreferences.getInstance();
                  var result = await clientSend.query(QueryOptions(
                    document: gql(savePatientReferral),
                    variables: {
                      "object": {
                        "city_id": userCities.city.id,
                        "name": nameController.text,
                        "age": ageController.text,
                        "gender": gender,
                        "phone": "+91" + mobileController.text,
                        "email": emailController.text
                      }
                    },
                  ));
                  print(result);
                  if (result.hasException) {
                    Constants.showFlushbarToast(
                        "Internal Server Error", context, 0);
                    if (mounted)
                      setState(() {
                        _isLoading = false;
                      });
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => ReferDetailScreen(),
                    ));
                    if (mounted)
                      setState(() {
                        _isLoading = false;
                      });
                  }
                }
              },
              child: Text(
                "Submit Referral to Nova",
              ),
            ),
          );
  }
}
