import 'package:flutter/material.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

import 'refer_detail_submitted.dart';

class ReferPatientScreen extends StatefulWidget {
  @override
  _ReferPatientScreenState createState() => _ReferPatientScreenState();
}

class _ReferPatientScreenState extends State<ReferPatientScreen> {
  String city = "Select City", age = "Age";

  List<String> ageList = ["Age"],
      cityList = ["Select City", "Surat", "Navsari"];

  @override
  void initState() {
    super.initState();

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
                        title: "Name",
                        hintText: "Name",
                        iconData: Icons.contact_phone),
                    titleAndField(
                      title: "Age",
                      hintText: "Age",
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
                      ),
                    ),
                    titleAndField(
                        title: "Mobile No.",
                        hintText: "+91 | Mobile Number",
                        iconData: Icons.phone),
                    titleAndField(
                      title: "City",
                      hintText: "City",
                      child: Container(
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
                          decoration: commonInputDecoration(
                              hintText: "City", showPostfixIcon: false),
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
                          // focusNode: cityNode,
                        ),
                      ),
                    ),
                    titleAndField(
                      title: "Reason for Referral",
                      hintText: "Write here...",
                    ),
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

  Widget titleAndField({
    required String title,
    required String hintText,
    Widget? child,
    int minLines = 1,
    IconData? iconData,
  }) {
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
                  // obscureText: obSecureText,
                  // focusNode: passwordNode,
                  // controller: passWordController,
                  minLines: minLines,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (val) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  decoration: commonInputDecoration(
                      hintText: hintText, iconData: iconData!),
                ),
              ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  InputDecoration commonInputDecoration(
      {required String hintText,
      bool showPostfixIcon = true,
      IconData? iconData}) {
    return InputDecoration(
        suffixIcon: showPostfixIcon
            ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(iconData),
                ),
              )
            : null,
        hintText: hintText,
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
    return commonButton(
        context: context,
        btnLabel: "Submit Referral to Nova",
        onPressed: () {});
  }
}
