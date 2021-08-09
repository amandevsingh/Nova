import 'package:flutter/material.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

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
                Image.asset(
                  ImgName.unionAbove,
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
                              padding: const EdgeInsets.only(left: 15.0),
                              child: CustomText(
                                txtTitle: "Back",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(color: Colors.white),
                              ),
                            )
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
                        txtTitle: "Dr. Manju Singh",
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
                                children: [ageField(), Spacer(), genderField()],
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
                              Row(
                                children: [cityField(), Spacer(), stateField()],
                              ),
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
          decoration: custInputDecoration(
              hintText: "Dr. Manju Singh",
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
          cursorHeight: 22.0,
          focusNode: _mobileNode,
          controller: _mobileController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (val) {},
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
          decoration: custInputDecoration(
              hintText: "manjus@novaivffertility.com",
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
