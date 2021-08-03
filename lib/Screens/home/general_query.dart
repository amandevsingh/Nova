import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/components/custom_dropdown.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

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
                    Image.asset(
                      ImgName.unionAbove,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
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
                          Image.asset(
                            ImgName.share,
                            height: 20.0,
                            width: 18.0,
                          ),
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
              focusNode: _optionNode,
              controller: _optionController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              decoration: custInputDecoration(
                  hintText: "Unable to view details of a patient"),
            ),
          ),
          CustomDropDown(
              height: 200.0,
              width: double.infinity,
              callback: (value) {},
              items: [
                "1",
                "2",
                "3",
                "4",
              ].map((e) => CustomDropDownItems(e, e)).toList()),
        ],
      ),
    );
  }

  Widget detailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
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
        decoration: custInputDecoration(hintText: "Write here..."),
      ),
    );
  }

  Widget buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                custThemeColor,
              ),
            ),
            onPressed: () {},
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

  InputDecoration custInputDecoration({@required String hintText}) {
    return InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: 13.0, color: Color(0xFFAEADAD)),
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
}
