import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/UserDetails.dart';
import 'package:flutter_auth/Screens/home/home_screen.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class ProfileScreen extends StatefulWidget {
  OrgUsers orgUsers;

  ProfileScreen({Key key, this.orgUsers}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FocusNode _nameNode = FocusNode();
  FocusNode _ageNode = FocusNode();
  FocusNode _genderNode = FocusNode();
  FocusNode _mobileNode = FocusNode();
  FocusNode _emailNode = FocusNode();
  FocusNode _cityNode = FocusNode();
  FocusNode _stateNode = FocusNode();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  String age = "Age", gender = "Gender";
  bool _isLoading = false;

  List<String> genderList = ["Gender", "Male", "Female"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.orgUsers?.name;
    _ageController.text = widget.orgUsers?.age.toString();
    _mobileController.text = widget.orgUsers?.phone;
    _emailController.text = widget.orgUsers?.email;
    gender = widget.orgUsers?.gender;
  }

  @override
  void dispose() {
    _nameNode.dispose();
    _ageNode.dispose();
    _genderNode.dispose();
    _mobileNode.dispose();
    _cityNode.dispose();
    _stateNode.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _mobileController.dispose();
    _cityController.dispose();
    _stateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F8),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(ImgName.union, fit: BoxFit.cover),
                Row(
                  children: [
                    Image.asset(ImgName.unionAbove,
                        height: 75.0, width: 50.0, fit: BoxFit.fill),
                    Spacer(),
                    Image.asset(ImgName.unionAboveB,
                        height: 75.0, width: 60.0, fit: BoxFit.fill),
                  ],
                ),
                Column(
                  children: [
                    //back button...
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              ImgName.back,
                              width: 10.0,
                              height: 18.0,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 23.0),
                              child: CustomText(
                                txtTitle: "My Profile",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //profile icon..
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Color(0xFFC52068),
                        child: Image.asset(
                          ImgName.patient,
                          color: Colors.white,
                          height: 15.0,
                          width: 15.0,
                        ),
                      ),
                    ),
                    //name..
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CustomText(
                        txtTitle: "Dr. " + widget.orgUsers?.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFFD6D6D6),
                                  offset: Offset(0, 3),
                                  blurRadius: 6.0)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                txtTitle: "Name",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.black),
                              ),
                              nameField(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 55,
                                        child: TextFormField(
                                          focusNode: _ageNode,
                                          controller: _ageController,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          maxLength: 2,
                                          onFieldSubmitted: (val) {
                                            FocusScope.of(context)
                                                .requestFocus(_genderNode);
                                          },
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                  fontSize: 13.0,
                                                  color: Colors.black
                                                      .withOpacity(0.80)),
                                          decoration: custInputDecoration(
                                              context: context,
                                              hintText: "Age"),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                                fontSize: 13.0,
                                                color: Colors.black
                                                    .withOpacity(0.80)),
                                        iconEnabledColor: Colors.white,

                                        decoration: custInputDecoration(
                                            context: context,
                                            hintText: "Gender"),
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
                                        focusNode: _genderNode,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              CustomText(
                                txtTitle: "Mobile No.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.black),
                              ),
                              mobileField(),
                              CustomText(
                                txtTitle: "Email ID",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.black),
                              ),
                              emailField(),
                              Visibility(
                                  visible: false,
                                  child: Row(
                                    children: [
                                      cityField(),
                                      Spacer(),
                                      stateField()
                                    ],
                                  )),
                              buildSaveButton()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        height: 45.0,
        child: TextFormField(
          cursorColor: custThemeColor,
          cursorHeight: 22.0,
          focusNode: _nameNode,
          controller: _nameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (val) {},
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: 13.0, color: Colors.black.withOpacity(0.80)),
          decoration: custInputDecoration(
              hintText: "",
              context: context,
              suffix: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  ImgName.name,
                ),
              )),
        ),
      ),
    );
  }

  Widget ageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: "Age",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: SizedBox(
            height: 45.0,
            width: 140.0,
            child: TextFormField(
              cursorColor: custThemeColor,
              cursorHeight: 22.0,
              focusNode: _ageNode,
              controller: _ageController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {},
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 13.0, color: Colors.black.withOpacity(0.80)),
              decoration: custInputDecoration(
                  hintText: "12 Jan 1988",
                  context: context,
                  suffix: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      ImgName.cal,
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }

  Widget genderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: "Gender",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: SizedBox(
              height: 45.0,
              width: 140.0,
              child: TextFormField(
                cursorColor: custThemeColor,
                cursorHeight: 22.0,
                focusNode: _genderNode,
                controller: _genderController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 13.0, color: Colors.black.withOpacity(0.80)),
                onFieldSubmitted: (val) {},
                decoration: custInputDecoration(
                    hintText: "Female",
                    context: context,
                    suffix: Icon(Icons.expand_more)),
              ),
            )),
      ],
    );
  }

  Widget mobileField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        height: 45.0,
        child: TextFormField(
          cursorColor: custThemeColor,
          readOnly: true,
          cursorHeight: 22.0,
          focusNode: _mobileNode,
          controller: _mobileController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (val) {},
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: 13.0, color: Colors.black.withOpacity(0.80)),
          decoration: custInputDecoration(
              hintText: "Dr. Manju Singh",
              context: context,
              suffix: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  ImgName.phone,
                ),
              )),
        ),
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        height: 45.0,
        child: TextFormField(
          cursorColor: custThemeColor,
          cursorHeight: 22.0,
          focusNode: _emailNode,
          controller: _emailController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (val) {},
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: 13.0, color: Colors.black.withOpacity(0.80)),
          decoration: custInputDecoration(
              hintText: "Please enter e-mail id.",
              context: context,
              suffix: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  ImgName.mail,
                ),
              )),
        ),
      ),
    );
  }

  Widget cityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: "City",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: SizedBox(
              height: 45.0,
              width: 140.0,
              child: TextFormField(
                cursorColor: custThemeColor,
                cursorHeight: 22.0,
                focusNode: _cityNode,
                controller: _cityController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {},
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 13.0, color: Colors.black.withOpacity(0.80)),
                decoration: custInputDecoration(
                    hintText: "Gurgaon",
                    context: context,
                    suffix: Icon(Icons.expand_more)),
              ),
            )),
      ],
    );
  }

  Widget stateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: "State",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.black),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: SizedBox(
              height: 45.0,
              width: 140.0,
              child: TextFormField(
                cursorColor: custThemeColor,
                cursorHeight: 22.0,
                focusNode: _stateNode,
                controller: _stateController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {},
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 13.0, color: Colors.black.withOpacity(0.80)),
                decoration: custInputDecoration(
                    hintText: "Haryana",
                    context: context,
                    suffix: Icon(Icons.expand_more)),
              ),
            )),
      ],
    );
  }

  Widget buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: _isLoading
          ? CircularProgressIndicator(
              color: custThemeColor,
            )
          : Container(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      custThemeColor,
                    ),
                  ),
                  onPressed: () async {
                    if (_nameController.text.isEmpty) {
                      Constants.showFlushbarToast(
                          "Please enter a valid Name.", context, 1);
                    } else if (_ageController.text.isEmpty) {
                      Constants.showFlushbarToast(
                          "Please enter age", context, 1);
                    } else if (gender == "Gender") {
                      Constants.showFlushbarToast(
                          "Please select gender.", context, 1);
                    } else if (_mobileController.text.isEmpty) {
                      Constants.showFlushbarToast(
                          "Please enter a valid Mobile No.", context, 1);
                    } else if (_emailController.text.isEmpty) {
                      Constants.showFlushbarToast(
                          "Please enter a valid email.", context, 1);
                    } else if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(_emailController.text) ==
                        false) {
                      Constants.showFlushbarToast(
                          "Please enter valid email id.", context, 1);
                    } else {
                      if (mounted)
                        setState(() {
                          _isLoading = true;
                        });
                      // Loader.show(context,
                      //     progressIndicator: CircularProgressIndicator(),
                      //     themeData: Theme.of(context)
                      //         .copyWith(accentColor: Color(0xff90244c)));
                      var prefs = await SharedPreferences.getInstance();
                      var result = await clientSend.query(QueryOptions(
                        document: gql(savePatientData),
                        variables: {
                          "_set": {
                            "age": _ageController.text,
                            "email": _emailController.text,
                            "gender": gender,
                            "name": _nameController.text
                          },
                          "pk_columns": {"id": prefs.getString(USER_ID)}
                        },
                      ));
                      print(result);
                      if (result.hasException) {
                        Constants.showFlushbarToast(
                            "Internal Server Error", context, 0);
                        // if (mounted)
                        setState(() {
                          _isLoading = false;
                        });
                        if (mounted)
                          setState(() {
                            _isLoading = false;
                          });
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => HomeScreen(),
                        ));
                        //if (mounted)
                        setState(() {
                          _isLoading = false;
                        });
                        if (mounted)
                          setState(() {
                            _isLoading = false;
                          });
                      }
                    }
                  },
                  child: CustomText(
                    txtTitle: "Save",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.white),
                  )),
            ),
    );
  }
}
