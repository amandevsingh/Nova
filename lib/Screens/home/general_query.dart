import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/home/perscription_requested.dart';
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

class GeneralQueryScreen extends StatefulWidget {
  GeneralQueryScreen({Key key}) : super(key: key);

  @override
  _GeneralQueryScreenState createState() => _GeneralQueryScreenState();
}

class _GeneralQueryScreenState extends State<GeneralQueryScreen> {
  FocusNode _optionNode = FocusNode();
  FocusNode _detailNode = FocusNode();
  TextEditingController _optionController = TextEditingController();
  TextEditingController _detailController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    _optionNode.dispose();
    _detailNode.dispose();
    _optionController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ));
    return GestureDetector(
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
                Hero(
                  tag: "query",
                  child: Stack(
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
              focusNode: _optionNode,
              controller: _optionController,
              onFieldSubmitted: (val) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              decoration: custInputDecoration(
                hintText: "Unable to view my patients list",
                context: context,
              ),
            ),
          ),
          CustomDropDown(
              currentText: _optionController.text,
              height: 300.0,
              width: double.infinity,
              callback: (value) {
                setState(() {
                  _optionController.text = value;
                });
              },
              items: [
                "Unable to view my patients list",
                "Need details of a particular patient",
                "Need status of referred patient",
                "Admin related query",
                "Others",
              ].map((e) => CustomDropDownItems(e, e, "")).toList()),
        ],
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
            custInputDecoration(context: context, hintText: "Write here..."),
      ),
    );
  }

  Widget buildSubmitButton() {
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
                        document: gql(saveGeneralQuery),
                        variables: {
                          "object": {
                            "title": _optionController.text,
                            "query_type": "self",
                            "user_query_notes": {
                              "data": {"remarks": _detailController.text}
                            }
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
                        if (mounted)
                          setState(() {
                            _isLoading = false;
                          });
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => ReferDetailScreen(),
                          ),
                        );
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
