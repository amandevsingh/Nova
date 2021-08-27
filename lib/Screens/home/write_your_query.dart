import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/PatientList.dart';
import 'package:flutter_auth/Screens/home/refer_detail_screen.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/custom_dropdown.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class WriteYourQuery extends StatefulWidget {
  ReferralPatientReferrals patientDetailModel;

  WriteYourQuery({Key key, this.patientDetailModel}) : super(key: key);

  @override
  _WriteYourQueryState createState() => _WriteYourQueryState();
}

class _WriteYourQueryState extends State<WriteYourQuery> {
  FocusNode _nameNode = FocusNode();
  FocusNode _numberNode = FocusNode();
  // FocusNode _optionNode = FocusNode();
  FocusNode _detailNode = FocusNode();
   bool _isLoading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _optionController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  @override
  void dispose() {
    _nameNode.dispose();
    _numberNode.dispose();
    _detailNode.dispose();
    _nameController.dispose();
    _numberController.dispose();
    _optionController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.patientDetailModel.name;
    _numberController.text = widget.patientDetailModel.phone;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 265.0,
                      width: double.infinity,
                      child: Image.asset(ImgName.union, fit: BoxFit.cover),
                    ),
                    Row(
                      children: [
                        Image.asset(ImgName.unionAbove,
                            height: 75.0, width: 50.0, fit: BoxFit.fill),
                        Spacer(),
                        Image.asset(ImgName.unionAboveB,
                            height: 75.0, width: 60.0, fit: BoxFit.fill),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 15.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                                color: Colors.white, size: 22.0),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CustomText(
                            txtTitle: "Back",
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                          ),
                          Spacer(),
                          Visibility(
                              visible: false,
                              child: Image.asset(
                                ImgName.share,
                                height: 20.0,
                                width: 18.0,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Image.asset(
                        ImgName.query,
                      ),
                    ),
                  ],
                ),
                //write your query label...
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Column(
                      children: [
                        CustomText(
                            txtTitle: "Write your query".toUpperCase(),
                            style: Theme.of(context).textTheme.headline2),
                        Container(
                          height: 1.0,
                          width: 180.0,
                          color: custThemeColor,
                        )
                      ],
                    ),
                  ),
                ),
                //select an option...
                Form(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          txtTitle: "Patient Name*",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                        ),
                        nameField(),
                        CustomText(
                          txtTitle: "Mobile No.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                        ),
                        numberField(),
                        CustomText(
                          txtTitle: "Select an Option*",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.black),
                        ),
                        selectOptionField(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: CustomText(
                            txtTitle:
                                "Please tell us in detail about your query.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        detailField(),
                        buildSubmitButton()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectOptionField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 45.0,
            child: TextFormField(
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: custThemeColor),
              readOnly: true,
              keyboardType: TextInputType.multiline,
              controller: _optionController,
              decoration: custInputDecoration(
                hintText: "Unable to view specific detail of the patient",
                context: context,
              ),
            ),
          ),
          CustomDropDown(
              height: 300.0,
              currentText: _optionController.text,
              width: double.infinity,
              callback: (value) {
                setState(() {
                  _optionController.text = value;
                });
              },
              items: [
                "Unable to view specific detail of the patient",
                "Connect to the consulting doctor",
                "Need more details about the treatment",
                "Others",
              ].map((e) => CustomDropDownItems(e, e, "")).toList()),
        ],
      ),
    );
  }

  Widget nameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        height: 45.0,
        child: TextFormField(
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: custThemeColor),
          readOnly: true,
          cursorColor: custThemeColor,
          cursorHeight: 22.0,
          focusNode: _nameNode,
          controller: _nameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (val) {
            FocusScope.of(context).requestFocus(_numberNode);
          },
          decoration: custInputDecoration(
              hintText: "Akansha Rawat",
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

  Widget numberField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        height: 45.0,
        child: TextFormField(
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: custThemeColor),
          readOnly: true,
          cursorColor: custThemeColor,
          cursorHeight: 22.0,
          focusNode: _numberNode,
          controller: _numberController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: custInputDecoration(
              hintText: "9023636589",
              context: context,
              suffix: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Image.asset(
                  ImgName.phone,
                ),
              )),
        ),
      ),
    );
  }

  Widget detailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: custThemeColor),
        cursorColor: custThemeColor,
        cursorHeight: 22.0,
        focusNode: _detailNode,
        controller: _detailController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        maxLines: 3,
        onFieldSubmitted: (val) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        decoration:
            custInputDecoration(hintText: "Write here...", context: context),
      ),
    );
  }

  Widget buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child:_isLoading?CircularProgressIndicator(color: custThemeColor,): Container(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                custThemeColor,
              ),
            ),
            onPressed: () async {
              if (_optionController.text.isEmpty) {
                Constants.showFlushbarToast(
                    "Please select option.", context, 1);
              } else {
                // Loader.show(context,
                //     progressIndicator: CircularProgressIndicator(),
                //     themeData: Theme.of(context)
                //         .copyWith(accentColor: Color(0xff90244c)));
                if (mounted)
                  setState(() {
                    _isLoading = true;
                  });
                var prefs = await SharedPreferences.getInstance();
                var result = await clientSend.query(QueryOptions(
                  document: gql(savePatientQuery),
                  variables: {
                    "object": {
                      "referral_id": widget.patientDetailModel.id,
                      //  "patient_name": widget.patientDetailModel.name,
                      //  "patient_phone": widget.patientDetailModel.phone,
                      "title": _optionController.text,
                      "query_type": "referral",
                      "user_query_notes": {
                        "data": {
                          "remarks": _detailController.text,
                        }
                      }
                    }
                  },
                ));
                if (result.hasException) {
                  Constants.showFlushbarToast(
                      "Internal Server Error", context, 0);
                  if (mounted)
                    setState(() {
                      _isLoading = false;
                    });
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => ReferDetailScreen(),
                    ),
                  );
                  if (mounted)
                    setState(() {
                      _isLoading = false;
                    });
                }
              }
            },
            child: CustomText(
              txtTitle: "Submit",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            )),
      ),
    );
  }
}
