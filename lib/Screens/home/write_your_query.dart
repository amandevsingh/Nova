import 'package:flutter/material.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/custom_dropdown.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class WriteYourQuery extends StatefulWidget {
  @override
  _WriteYourQueryState createState() => _WriteYourQueryState();
}

class _WriteYourQueryState extends State<WriteYourQuery> {
  FocusNode _nameNode = FocusNode();
  FocusNode _numberNode = FocusNode();
  FocusNode _optionNode = FocusNode();
  FocusNode _detailNode = FocusNode();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _optionController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  @override
  void dispose() {
    _nameNode.dispose();
    _numberNode.dispose();
    _optionNode.dispose();
    _detailNode.dispose();
    _nameController.dispose();
    _numberController.dispose();
    _optionController.dispose();
    _detailController.dispose();
    super.dispose();
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
                                ?.copyWith(
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
                          txtTitle: "Patient Name*",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.black),
                        ),
                        nameField(),
                        CustomText(
                          txtTitle: "Mobile No.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.black),
                        ),
                        numberField(),
                        CustomText(
                          txtTitle: "Select an Option*",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.black),
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
                                ?.copyWith(color: Colors.black),
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
                hintText: "Unable to view details of a patient",
                context: context,
              ),
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
          cursorColor: custThemeColor,
          cursorHeight: 22.0,
          focusNode: _numberNode,
          controller: _numberController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (val) {
            FocusScope.of(context).requestFocus(_optionNode);
          },
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
        child: commonButton(
            context: context, btnLabel: "Submit", onPressed: () {}));
  }
}
