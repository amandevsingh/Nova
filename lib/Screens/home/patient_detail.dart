import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/PatientList.dart';
import 'package:flutter_auth/Models/TreatmentDetails.dart';
import 'package:flutter_auth/Screens/home/patient_listing.dart';
import 'package:flutter_auth/Screens/home/perscription_requested.dart';
import 'package:flutter_auth/Screens/home/write_your_query.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../constants.dart';

enum ExpandType { Expand_All, Collapse_All }
enum SelectDocumentType { Prescription_Document, All_Reports }

class PatientDetail extends StatefulWidget {
  final int index;
  ReferralPatientReferrals patientDetailModel;
  bool clickExpandAll = false;
  ListType listType;

  String selectedDocumentTYpe;
  List<String> selectedList = List();

  PatientDetail({Key key, this.listType, this.patientDetailModel, this.index})
      : super(key: key);

  @override
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  ExpandType selectExpandType = ExpandType.Collapse_All;
  TreatmentDetails treatmentDetails = TreatmentDetails();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.selectedList.clear();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return GraphQLProvider(
        child: Scaffold(
            backgroundColor: Color(0xFFF7F7F7),
            body: SafeArea(
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
                                height: 75.0, width: 50.0, fit: BoxFit.fill),
                            Spacer(),
                            Image.asset(ImgName.unionAboveB,
                                height: 75.0, width: 60.0, fit: BoxFit.fill),
                          ],
                        ),
                        //detail card...
                        Hero(tag: "detail${widget.index}", child: detailCard()),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 15.0),
                          child: Row(
                            children: [
                              //back button...
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: Colors.white, size: 22.0),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              //notification label...
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
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                anotherAnimation) {
                                              return WriteYourQuery(
                                                  patientDetailModel: widget
                                                      .patientDetailModel);
                                            },
                                            transitionDuration:
                                                Duration(milliseconds: 700),
                                            transitionsBuilder: (context,
                                                animation,
                                                anotherAnimation,
                                                child) {
                                              animation = CurvedAnimation(
                                                  curve: Curves.easeIn,
                                                  parent: animation);
                                              return Align(
                                                child: SlideTransition(
                                                  position: Tween(
                                                          begin:
                                                              Offset(1.0, 0.0),
                                                          end: Offset(0.0, 0.0))
                                                      .animate(animation),
                                                  child: child,
                                                ),
                                              );
                                            })
                                        // MaterialPageRoute(
                                        //   builder: (ctx) => WriteYourQuery(
                                        //       patientDetailModel:
                                        //           widget.patientDetailModel),
                                        // ),
                                        );
                                  },
                                  child: Image.asset(
                                    ImgName.msgWhite,
                                    height: 25.0,
                                    width: 25.0,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //sticky list...
                    Query(
                        options: QueryOptions(
                            document: gql(getTreatmentDetail),
                            variables: {
                              "referral_id": widget.patientDetailModel.id
                            },
                            pollInterval: Duration(minutes: 5)),
                        builder: (QueryResult result,
                            {VoidCallback refetch, FetchMore fetchMore}) {
                          if (result.data != null) {
                            if (widget.clickExpandAll == false) {
                              treatmentDetails =
                                  TreatmentDetails.fromJson(result.data);
                            }
                          } else if (widget.listType == ListType.In_Active) {
                            // ignore: deprecated_member_use
                            List<TreatmentData> treatmentDataList = List();
                            List<dynamic> list = List();
                            List<List<dynamic>> listp = List();
                            list.add("Patient Referred To Nova");
                            listp.add(list);
                            TreatmentData treatmentData = TreatmentData();
                            treatmentData.lastStatus =
                                "Patient Referred To Nova";
                            treatmentData.treatmentCycle = "";
                            treatmentData.lastStatusDate =
                                widget.patientDetailModel.referredDate;
                            treatmentData.values = listp;
                            treatmentData.isExpand = false;
                            treatmentData.cycle = 0;
                            treatmentData.dates = [
                              widget.patientDetailModel.referredDate
                            ];
                            treatmentData.datesIsExpand = [false];
                            treatmentDataList.add(treatmentData);
                            treatmentDetails.treatmentData = treatmentDataList;
                            return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //current status card...
                                  currentStatusCard(),
                                  //collapse and expand all...
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        expandCollapseButton(
                                            ExpandType.Collapse_All),
                                        SizedBox(width: 15.0),
                                        expandCollapseButton(
                                            ExpandType.Expand_All)
                                      ],
                                    ),
                                  ),
                                  stickyHeaderList()
                                ]);
                          }
                          return Center(
                              child: result.hasException
                                  ? Text("")
                                  : result.isLoading
                                      ? CircularProgressIndicator()
                                      : Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              //current status card...
                                              currentStatusCard(),
                                              //collapse and expand all...
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    expandCollapseButton(
                                                        ExpandType
                                                            .Collapse_All),
                                                    SizedBox(width: 15.0),
                                                    expandCollapseButton(
                                                        ExpandType.Expand_All)
                                                  ],
                                                ),
                                              ),
                                              stickyHeaderList()
                                            ]));
                        }),
                    //request more document button...
                    Visibility(
                        visible: widget.listType == ListType.Active,
                        child: requestMoreDocumentButton()),
                  ],
                ),
              ),
            )),
        client: client);
  }

  Widget detailCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 70.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 1.0),
                  blurRadius: 8,
                  color: Color(0xFFD6D6D6)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomText(
                    txtTitle: "${widget.patientDetailModel.name}, ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.black),
                  ),
                  CustomText(
                    txtTitle:
                        "${widget.patientDetailModel.age}yrs, ${widget.patientDetailModel.gender}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.black, fontSize: 11.0),
                  ),
                ],
              ),
              Row(
                children: [
                  CustomText(
                    txtTitle: "Mobile: " + widget.patientDetailModel.phone,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.black, fontSize: 11.0),
                  ),
                  Spacer(),
                  CustomText(
                    txtTitle: "Centre: Mum-Vashi",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.black, fontSize: 11.0),
                  )
                ],
              ),
              Row(
                children: [
                  CustomText(
                    txtTitle:
                        "Referred Date: ${isTest(widget.patientDetailModel.referredDate ?? "")}",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.black, fontSize: 11.0),
                  ),
                  Spacer(),
                  Visibility(
                      visible: true,
                      child: CustomText(
                        txtTitle:
                            "Registration: ${isTest((widget.listType == ListType.Active ? widget.patientDetailModel.registrations[0].patientRegistration?.registeredDate : "") ?? "")}",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.black, fontSize: 11.0),
                      ))
                ],
              ),
              CustomText(
                txtTitle: "Treatment Under: " +
                        (widget.listType == ListType.Active
                            ? widget.patientDetailModel.registrations[0]
                                .patientRegistration?.consultantName
                            : "") ??
                    "",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.black, fontSize: 11.0),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget currentStatusCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: 85.0,
        color: custThemeColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Container(
                height: 42.0,
                width: 60.0,
                decoration: BoxDecoration(
                    color: Color(0xFFF7F8FA),
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
                child: Center(
                  child: Column(
                    children: [
                      CustomText(
                        txtTitle: isTestDayMonth(treatmentDetails
                                ?.treatmentData[0]?.lastStatusDate)
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      CustomText(
                        txtTitle: isTestYear(
                            treatmentDetails?.treatmentData[0]?.lastStatusDate),
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                ),
              ),
              //current status field...
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 250,
                        child: CustomText(
                          textOverflow: TextOverflow.ellipsis,
                          maxLine: 3,
                          txtTitle: "Current Status: " +
                                  treatmentDetails
                                      ?.treatmentData[0]?.lastStatus ??
                              "",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(fontSize: 11.0, color: Colors.white),
                        )),
                    CustomText(
                      txtTitle: "Treatment Cycle: " +
                              treatmentDetails
                                  ?.treatmentData[0]?.treatmentCycle ??
                          "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget stickyHeaderList() {
    return ListView.builder(
      itemCount: treatmentDetails.treatmentData.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, headeri) => StickyHeader(
        header: Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 15.0),
          child: Container(
            height: 26.0,
            width: headeri == 0 ? 80.0 : 70.0,
            decoration: BoxDecoration(
                color: Color(0xFFDEDEE0),
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Center(
              child: CustomText(
                txtTitle: headeri == 0
                    ? "Current Cycle"
                    : "Cycle " +
                        treatmentDetails.treatmentData[headeri].cycle
                            .toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Color(0xFF74787A), fontSize: 10.0),
              ),
            ),
          ),
        ),
        content: ListView.builder(
          itemCount: treatmentDetails.treatmentData[headeri].dates.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, i) =>
              taskCard(treatmentDetails.treatmentData[headeri], i, headeri),
        ),
      ),
    );
  }

  Widget requestMoreDocumentButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      child: Container(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                custThemeColor,
              ),
            ),
            onPressed: () {
              return showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter mystate) {
                      return Container(
                          clipBehavior: Clip.antiAlias,
                          height: MediaQuery.of(context).size.height * 0.50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(74.0),
                                  topRight: Radius.circular(74.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: CustomText(
                                    txtTitle: "Request Document".toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0),
                                  child: Divider(color: custThemeColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: CustomText(
                                    txtTitle: "Please select document type",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Checkbox(
                                          activeColor: custThemeColor,
                                          value: widget.selectedList.contains(
                                              "Prescription Document"),
                                          onChanged: (_) {
                                            if (mounted)
                                              mystate(() {
                                                widget.selectedDocumentTYpe =
                                                    "Prescription Document";
                                                if (widget.selectedList
                                                    .contains(widget
                                                        .selectedDocumentTYpe))
                                                  widget.selectedList.remove(
                                                      widget
                                                          .selectedDocumentTYpe);
                                                else {
                                                  widget.selectedList.add(widget
                                                      .selectedDocumentTYpe);
                                                }
                                              });
                                          }),
                                    ),
                                    CustomText(
                                      txtTitle: "Prescription Document",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(color: Colors.black),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Checkbox(
                                          activeColor: custThemeColor,
                                          value: widget.selectedList
                                              .contains("All Reports"),
                                          onChanged: (_) {
                                            if (mounted)
                                              mystate(() {
                                                widget.selectedDocumentTYpe =
                                                    "All Reports";
                                                if (widget.selectedList
                                                    .contains(widget
                                                        .selectedDocumentTYpe))
                                                  widget.selectedList.remove(
                                                      widget
                                                          .selectedDocumentTYpe);
                                                else {
                                                  widget.selectedList.add(widget
                                                      .selectedDocumentTYpe);
                                                }
                                              });
                                          }),
                                    ),
                                    CustomText(
                                      txtTitle: "All Reports",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(color: Colors.black),
                                    )
                                  ],
                                ),
                                submitButton()
                              ],
                            ),
                          ));
                    });
                  });
            },
            child: CustomText(
              txtTitle: "Request More Documents",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            )),
      ),
    );
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: _isLoading
          ? CircularProgressIndicator(
              color: custThemeColor,
            )
          : Container(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      custThemeColor,
                    ),
                  ),
                  onPressed: () async {
                    //Navigator.of(context).pop();
                    if (widget.selectedList.isEmpty) {
                      Constants.showFlushbarToast(
                          "Please select document type.", context, 1);
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
                        document: gql(saveDocumentQuery),
                        variables: {
                          "object": {
                            "title": "Request Document",
                            "referral_id": widget.patientDetailModel.id,
                            "document_type":
                                "{" + widget.selectedList.join(',') + "}",
                            "query_type": "document",
                            "user_query_notes": {
                              "data": {
                                "remarks":
                                    "please provide all reports for this patient.",
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
                        if (mounted)
                          setState(() {
                            _isLoading = false;
                          });
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => PerscriptionRequested(
                                name: widget.patientDetailModel.name),
                          ),
                        );
                      }
                    }
                  },
                  child: CustomText(
                    txtTitle: "Submit",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                  )),
            ),
    );
  }

  Widget expandCollapseButton(ExpandType expandType) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.clickExpandAll = true;
          treatmentDetails.treatmentData.forEach((element) {
            element.datesIsExpand.forEach((elements) {
              elements = !elements;
            });
          });
          selectExpandType = selectExpandType == ExpandType.Expand_All
              ? ExpandType.Collapse_All
              : ExpandType.Expand_All;
        });
      },
      child: Container(
        height: 23.0,
        width: 100.0,
        decoration: BoxDecoration(
            color:
                selectExpandType == expandType ? custThemeColor : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        child: Center(
          child: CustomText(
            txtTitle: describeEnum(expandType).replaceAll("_", " "),
            style: Theme.of(context).textTheme.caption.copyWith(
                color: selectExpandType == expandType
                    ? Colors.white
                    : custThemeColor),
          ),
        ),
      ),
    );
  }

  Widget taskCard(TreatmentData taskListModel, int index, int headeri) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txtTitle: isTestDayMonth(taskListModel.dates[index]),
                  style: Theme.of(context).textTheme.caption,
                ),
                CustomText(
                  txtTitle: isTestYear(taskListModel.dates[index]),
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
          ),
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 11.0,
                    backgroundColor: Color(0xFFEDEDED),
                  ),
                  CircleAvatar(
                    radius: 7.0,
                    backgroundColor: index == 0 && headeri == 0
                        ? custThemeColor
                        : Color(0xFFC9CBCD),
                  ),
                ],
              ),
              DottedLine(
                direction: Axis.vertical,
                dashColor: Color(0xFFDEDFE1),
                lineLength: (((selectExpandType == ExpandType.Expand_All) ||
                        treatmentDetails
                            .treatmentData[headeri].datesIsExpand[index])
                    ? 180
                    : 100),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFFAF9F7),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    border: Border.all(color: Color(0xFFE6D2DB)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 1.0),
                          blurRadius: 8,
                          color: Color(0xFFDBDBDB)),
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15.0, top: 15.0, left: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Container(
                                  height: 1.0,
                                  width: 15.0,
                                  color: custThemeColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: ((selectExpandType ==
                                                    ExpandType.Expand_All) ||
                                                treatmentDetails
                                                    .treatmentData[headeri]
                                                    .datesIsExpand[index]) ==
                                            false
                                        ? 1
                                        : treatmentDetails
                                            .treatmentData[headeri]
                                            .values[index]
                                            .length,
                                    itemBuilder: (context, position) {
                                      return Column(
                                        children: <Widget>[
                                          //Divider(height: 0.5),
                                          ListTile(
                                            title: CustomText(
                                              txtTitle: treatmentDetails
                                                  .treatmentData[headeri]
                                                  .values[index][position],
                                              style: position == 0
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .copyWith(fontSize: 13.0)
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                              maxLine: 21,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                            ),
                                            onTap: () => {},
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ]),
                      ),
                      Visibility(
                          visible: treatmentDetails
                                  .treatmentData[headeri].values[index].length >
                              1,
                          child: IconButton(
                            onPressed: () {
                              widget.clickExpandAll = true;
                              if (mounted)
                                setState(() {
                                  taskListModel.datesIsExpand[index] =
                                      !taskListModel.datesIsExpand[index];
                                });
                            },
                            icon: RotatedBox(
                              quarterTurns: ((selectExpandType ==
                                          ExpandType.Expand_All) ||
                                      treatmentDetails.treatmentData[headeri]
                                          .datesIsExpand[index])
                                  ? 1
                                  : 3,
                              child: Image.asset(
                                ImgName.back,
                                height: 11.0,
                                width: 7.0,
                                color: custThemeColor,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String isTest(String value) {
    if (value.isNotEmpty) {
      var parts = value.split('T');
      var prefix = parts[0].trim();
      var inputDate = DateFormat('yyyy-MM-dd').parse(prefix);
      var outputFormat = DateFormat('dd-MMM-yyyy');
      return outputFormat.format(inputDate);
    } else {
      return "";
    }
  }

  String isTestYear(String value) {
    if (value.isNotEmpty) {
      var parts = value.split('T');
      var prefix = parts[0].trim();
      var inputDate = DateFormat('yyyy-MM-dd').parse(prefix);
      var outputFormat = DateFormat('yyyy');
      return outputFormat.format(inputDate);
    } else {
      return "";
    }
  }

  String isTestDayMonth(String value) {
    if (value.isNotEmpty) {
      var parts = value.split('T');
      var prefix = parts[0].trim();
      var inputDate = DateFormat('yyyy-MM-dd').parse(prefix);
      var outputFormat = DateFormat('dd MMM');
      return outputFormat.format(inputDate).toUpperCase();
    } else {
      return "           ";
    }
  }
}
