import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/PatientList.dart';
import 'package:flutter_auth/Screens/home/patient_detail.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'general_query.dart';

enum ListType { Active, In_Active }

class PatientListing extends StatefulWidget {
  PatientListing({Key key}) : super(key: key);

  @override
  _PatientListingState createState() => _PatientListingState();
}

class _PatientListingState extends State<PatientListing> {
  ListType selectListType = ListType.Active;
  PatientList _patientList = new PatientList();
  PatientList _patientListInActive = new PatientList();
  TextEditingController searchController = TextEditingController();

  List<ReferralPatientReferrals> displayList =
      new List<ReferralPatientReferrals>();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        child: Query(
            options: QueryOptions(
                document: gql(getActivePatients),
                pollInterval: Duration(minutes: 5)),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.data != null) {
                _patientList = PatientList.fromJson(result.data);
                displayList = selectListType == ListType.Active
                    ? _patientList.referralPatientReferrals
                    : _patientListInActive.referralPatientReferrals;
              }

              return Query(
                  options: QueryOptions(
                      document: gql(getInActivePatients),
                      pollInterval: Duration(minutes: 5)),
                  builder: (QueryResult result,
                      {VoidCallback refetch, FetchMore fetchMore}) {
                    if (result.data != null) {
                      _patientListInActive = PatientList.fromJson(result.data);
                      displayList = selectListType == ListType.Active
                          ? _patientList.referralPatientReferrals
                          : _patientListInActive.referralPatientReferrals;
                    }

                    return Scaffold(
                      backgroundColor: Color(0xFFF1F1F2),
                      body: GestureDetector(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        child: SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    //union...
                                    Image.asset(
                                      ImgName.uni,
                                    ),
                                    //union design...
                                    Row(
                                      children: [
                                        Image.asset(ImgName.unionAbove,
                                            height: 75.0,
                                            width: 50.0,
                                            fit: BoxFit.fill),
                                        Spacer(),
                                        Image.asset(ImgName.unionAboveB,
                                            height: 75.0,
                                            width: 60.0,
                                            fit: BoxFit.fill),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, right: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.arrow_back_ios,
                                                    color: Colors.white,
                                                    size: 22.0),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              //notification label...
                                              CustomText(
                                                txtTitle: "My Patients",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white),
                                              ),
                                              Spacer(),
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        PageRouteBuilder(
                                                            pageBuilder: (context,
                                                                animation,
                                                                anotherAnimation) {
                                                              return GeneralQueryScreen();
                                                            },
                                                            transitionDuration:
                                                                Duration(
                                                                    milliseconds:
                                                                        700),
                                                            transitionsBuilder:
                                                                (context,
                                                                    animation,
                                                                    anotherAnimation,
                                                                    child) {
                                                              animation = CurvedAnimation(
                                                                  curve: Curves
                                                                      .easeIn,
                                                                  parent:
                                                                      animation);
                                                              return Align(
                                                                child:
                                                                    SlideTransition(
                                                                  position: Tween(
                                                                          begin: Offset(
                                                                              1.0,
                                                                              0.0),
                                                                          end: Offset(
                                                                              0.0,
                                                                              0.0))
                                                                      .animate(
                                                                          animation),
                                                                  child: child,
                                                                ),
                                                              );
                                                            })
                                                        //   MaterialPageRoute(
                                                        //     builder: (ctx) =>
                                                        //         GeneralQueryScreen(),
                                                        //   ),
                                                        );
                                                  },
                                                  child: Image.asset(
                                                    ImgName.msgWhite,
                                                    height: 25.0,
                                                    width: 25.0,
                                                  )),
                                            ],
                                          ),
                                          //search field...
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                                top: 15.0),
                                            child: SizedBox(
                                              height: 42.0,
                                              child: TextFormField(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                          color:
                                                              custThemeColor),
                                                  controller: searchController,
                                                  cursorColor: Colors.white,
                                                  cursorHeight: 22.0,
                                                  //controller: _searchController,
                                                  decoration:
                                                      searchFieldInputDecoration(
                                                          hintText:
                                                              "Patient Name or number"
                                                                  .toUpperCase()),
                                                  onChanged: (_) {
                                                    if (mounted)
                                                      setState(() {});
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                searchController.text.isNotEmpty
                                    ? searchActiveWidget()
                                    : Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            activeInActiveButton(
                                                ListType.Active),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            activeInActiveButton(
                                                ListType.In_Active)
                                          ],
                                        ),
                                      ),
                                searchController.text.isNotEmpty
                                    ? Container()
                                    : SizedBox(
                                        height: 500.0,
                                        child: ListView.builder(
                                            itemCount: displayList == null
                                                ? 0
                                                : displayList.length,
                                            itemBuilder: (context, i) => Hero(
                                                  tag: "detail$i",
                                                  child: Material(
                                                    child: patientCard(
                                                        displayList[i], i),
                                                  ),
                                                )),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }),
        client: client);
  }

  Widget activeInActiveButton(ListType listType) {
    return InkWell(
      onTap: () {
        if (mounted)
          setState(() {
            selectListType = selectListType == ListType.Active
                ? ListType.In_Active
                : ListType.Active;
          });
        displayList = selectListType == ListType.Active
            ? _patientList.referralPatientReferrals
            : _patientListInActive.referralPatientReferrals;
      },
      child: Container(
        height: 23.0,
        width: 100.0,
        decoration: BoxDecoration(
            color: selectListType == listType ? custThemeColor : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                txtTitle: describeEnum(listType).replaceAll("_", " "),
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: selectListType == listType
                        ? Colors.white
                        : Color(0xFF777777)),
              ),
              selectListType == listType ? Spacer() : Container(),
              selectListType == listType
                  ? CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.white,
                      child: CustomText(
                        txtTitle: (selectListType == ListType.Active
                                ? _patientList?.referralPatientReferrals?.length
                                : _patientListInActive
                                    ?.referralPatientReferrals?.length)
                            .toString(),
                        style: Theme.of(context).textTheme.overline,
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  String isTest(String value) {
    try {
      var parts = value.split('T');
      var prefix = parts[0].trim();
      var inputDate = DateFormat('yyyy-MM-dd').parse(prefix);
      var outputFormat = DateFormat('dd-MMM-yyyy');
      return outputFormat.format(inputDate);
    } catch (err) {
      return "--                ";
    }
  }

  Widget patientCard(ReferralPatientReferrals patientDetailModel, int i) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return PatientDetail(
                        index: i,
                        listType: selectListType,
                        patientDetailModel: patientDetailModel);
                  },
                  transitionDuration: Duration(milliseconds: 700),
                  transitionsBuilder:
                      (context, animation, anotherAnimation, child) {
                    animation = CurvedAnimation(
                        curve: Curves.easeIn, parent: animation);
                    return Align(
                      child: SlideTransition(
                        position: Tween(
                                begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                        child: child,
                      ),
                    );
                  })
              // MaterialPageRoute(
              //   builder: (ctx) => PatientDetail(
              //       index: i,
              //       listType: selectListType,
              //       patientDetailModel: patientDetailModel),
              // ),
              );
        }, // Handle your callback
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 96.0,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0.0, 3.0),
                      blurRadius: 6.0,
                      color: Color(0xFFD6D6D6))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 17.0, vertical: 13.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImgName.patient,
                    height: 42.0,
                    width: 42.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          txtTitle:
                              "${patientDetailModel.name}, ${patientDetailModel.age}yrs, ${patientDetailModel.gender}",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.black),
                        ),
                        Row(
                          children: [
                            CustomText(
                              txtTitle: patientDetailModel.phone,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: Colors.black, fontSize: 11.0),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CustomText(
                                txtTitle:
                                    "Referred on: ${isTest(patientDetailModel.referredDate ?? "")}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        color: Colors.black, fontSize: 11.0),
                              ),
                            )
                          ],
                        ),
                        Visibility(
                            visible: selectListType == ListType.Active
                                ? true
                                : false,
                            child: Row(
                              children: [
                                CustomText(
                                  txtTitle:
                                      "Latest Status: ${isTest(patientDetailModel.treatmentStatus?.treatmentDate ?? "")}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(color: Colors.black),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Visibility(
                                    visible: selectListType == ListType.Active
                                        ? true
                                        : false,
                                    child: CustomText(
                                      txtTitle: patientDetailModel
                                              ?.treatmentStatus
                                              ?.treatmentStatus ??
                                          "On-Going",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                              fontSize: 10.0,
                                              color: patientDetailModel
                                                          ?.treatmentStatus
                                                          ?.treatmentStatus ==
                                                      "Completed"
                                                  ? Colors.green
                                                  : patientDetailModel
                                                              ?.treatmentStatus
                                                              ?.treatmentStatus ==
                                                          "Stopped"
                                                      ? Colors.red
                                                      : custThemeColor),
                                    ))
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  InputDecoration searchFieldInputDecoration({@required String hintText}) {
    return InputDecoration(
        contentPadding: EdgeInsets.only(left: 20.0),
        filled: true,
        fillColor: Color(0xFFFFFFFF).withOpacity(0.32),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            ImgName.search,
            height: 16.0,
            width: 16.0,
          ),
        ),
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .caption
            .copyWith(color: Colors.white.withOpacity(0.32)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ));
  }

  Widget searchActiveWidget() {
    final activeSearchList = _patientList.referralPatientReferrals
        .where((element) =>
            element.name
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            element.phone.contains(searchController.text.toLowerCase()))
        .toList();
    final inActivesearchList = _patientListInActive.referralPatientReferrals
        .where((element) =>
            element.name
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            element.phone.contains(searchController.text.toLowerCase()))
        .toList();
    List<Map<String, dynamic>> searchList = [
      {"header": "Active", "patinetList": activeSearchList},
      {"header": "In-Active", "patinetList": inActivesearchList}
    ];
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: searchList.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => StickyHeader(
            header: CustomText(
              txtTitle: searchList[index]["header"],
              style: Theme.of(context).textTheme.bodyText1,
            ),
            content: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) => patientSearchcard(
                    searchList[index]["patinetList"][i], ListType.In_Active),
                separatorBuilder: (context, i) => Divider(
                      color: Colors.grey,
                    ),
                itemCount: searchList[index]["patinetList"].length),
          ),
        ));
  }

  Widget patientSearchcard(
      ReferralPatientReferrals referralPatientReferrals, ListType listType) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return PatientDetail(
                        listType: selectListType,
                        patientDetailModel: referralPatientReferrals);
                  },
                  transitionDuration: Duration(milliseconds: 700),
                  transitionsBuilder:
                      (context, animation, anotherAnimation, child) {
                    animation = CurvedAnimation(
                        curve: Curves.easeIn, parent: animation);
                    return Align(
                      child: SlideTransition(
                        position: Tween(
                                begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                        child: child,
                      ),
                    );
                  })
              // MaterialPageRoute(
              //   builder: (ctx) => PatientDetail(
              //       listType: selectListType,
              //       patientDetailModel: referralPatientReferrals),
              // ),
              );
        }, // Handle your callback
        child: SizedBox(
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                listType == ListType.Active ? ImgName.active : ImgName.inActive,
                height: 36.0,
                width: 36.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      txtTitle:
                          "${referralPatientReferrals.name}, ${referralPatientReferrals.age}yrs, ${referralPatientReferrals.gender}",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            txtTitle: referralPatientReferrals.phone,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          CustomText(
                            txtTitle:
                                "Referred on: ${isTest(referralPatientReferrals.referredDate)}",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
