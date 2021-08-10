import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/task_list_model.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../../components/common.dart';

enum ExpandType { Expand_All, Collapse_All }
enum SelectDocumentType { Prescription_Document, All_Reports }

class PatientDetail extends StatefulWidget {
  @override
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  ExpandType selectExpandType = ExpandType.Collapse_All;
  SelectDocumentType selectDocumentType = SelectDocumentType.All_Reports;
  List<TaskListModel> taskList = [
    TaskListModel(
        title: "Patient Consent Received",
        description:
            "Treatment Type: FET SELF female Diagnosis: male Diagnosis:",
        isExpand: false),
    TaskListModel(
        title: "Treatment Advised to Patient",
        description:
            "Treatment Type: FET SELF female Diagnosis: male Diagnosis:",
        isExpand: false),
    TaskListModel(
        title: "Pregnancy Outcome Measure - Clinical Pregnancy",
        description:
            "Bhcg Report 1 date: 27 mar 2021 BHCG Report 1 Value: 1439 Pregnancy Type: Intrauterine #sacs: 1",
        isExpand: false)
  ];

  List<String> cycleList = ["Current Cycle", "Cycle 1", "Cycle 2"];

  bool selectValue = false;
  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  //union...
                  Image.asset(ImgName.uni, fit: BoxFit.cover),
                  //union design...
                  Image.asset(ImgName.unionAbove, fit: BoxFit.cover),
                  //detail card...
                  detailCard(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 15.0),
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
                        //back label...
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
                          ImgName.msgWhite,
                          height: 25.0,
                          width: 25.0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //current status card...
              currentStatusCard(),
              //collapse and expand all...
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    expandCollapseButton(ExpandType.Collapse_All),
                    SizedBox(width: 15.0),
                    expandCollapseButton(ExpandType.Expand_All)
                  ],
                ),
              ),
              //sticky list...
              stickyHeaderList(),
              //request more document button...
              requestMoreDocumentButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 70.0),
      child: Container(
        height: 120,
        width: double.infinity,
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                txtTitle: "Sheetal Shirke, 34yrs, F",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.black),
              ),
              Row(
                children: [
                  CustomText(
                    txtTitle: "Mobile: 9843216666",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Colors.black),
                  ),
                  Spacer(),
                  CustomText(
                    txtTitle: "Centre: Mum-Vashi",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Colors.black),
                  )
                ],
              ),
              Row(
                children: [
                  CustomText(
                    txtTitle: "Referred Date:",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Colors.black),
                  ),
                  Spacer(),
                  CustomText(
                    txtTitle: "Registration: 09 Nov 2021",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Colors.black),
                  )
                ],
              ),
              CustomText(
                txtTitle: "Treatment Under: Dr. Akash Surana",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.black),
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
                        txtTitle: "25 Feb".toUpperCase(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      CustomText(
                        txtTitle: "2021",
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
                    CustomText(
                      txtTitle: "Current Status: Patient Consent Received",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(fontSize: 11.0, color: Colors.white),
                    ),
                    CustomText(
                      txtTitle: "Treatment Cycle: FET Self",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.white),
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
      itemCount: cycleList.length,
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
                txtTitle: cycleList[headeri],
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Color(0xFF74787A), fontSize: 10.0),
              ),
            ),
          ),
        ),
        content: ListView.builder(
          itemCount: taskList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, i) => taskCard(taskList[i], i, headeri),
        ),
      ),
    );
  }

  Widget requestMoreDocumentButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      child: commonButton(
        context: context,
        btnLabel: "Request More Documents",
        onPressed: () {
          return modalBottomSheet();
        },
      ),
    );
  }

  void modalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Material(
              child: Container(
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
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: CustomText(
                            txtTitle: "Request Document".toUpperCase(),
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Divider(color: custThemeColor),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: CustomText(
                            txtTitle: "Please select document type",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: custThemeColor,
                                value: selectDocumentType ==
                                    SelectDocumentType.Prescription_Document,
                                onChanged: (_) {
                                  if (mounted)
                                    setState(() {
                                      selectDocumentType = SelectDocumentType
                                          .Prescription_Document;
                                    });
                                }),
                            CustomText(
                              txtTitle: "Prescription Document",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: Colors.black),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: custThemeColor,
                                value: selectDocumentType ==
                                    SelectDocumentType.All_Reports,
                                onChanged: (_) {
                                  if (mounted)
                                    setState(() {
                                      selectDocumentType =
                                          SelectDocumentType.All_Reports;
                                    });
                                }),
                            CustomText(
                              txtTitle: "All Reports",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: Colors.black),
                            )
                          ],
                        ),
                        submitButton()
                      ],
                    ),
                  )),
            ));
  }

  Widget submitButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: commonButton(
            context: context, btnLabel: "Submit", onPressed: () {}));
  }

  Widget expandCollapseButton(ExpandType expandType) {
    return InkWell(
      onTap: () {
        taskList.forEach((element) {
          element.isExpand = !element.isExpand;
        });
        if (mounted)
          setState(() {
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
            style: Theme.of(context).textTheme.caption?.copyWith(
                color: selectExpandType == expandType
                    ? Colors.white
                    : custThemeColor),
          ),
        ),
      ),
    );
  }

  Widget taskCard(TaskListModel taskListModel, int index, int headeri) {
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
                  txtTitle: "25 Feb".toUpperCase(),
                  style: Theme.of(context).textTheme.caption,
                ),
                CustomText(
                  txtTitle: "2021",
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
                lineLength: taskListModel.isExpand ? 180 : 100,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
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
                  padding: const EdgeInsets.only(
                      bottom: 15.0, top: 15.0, left: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 1.0,
                                width: 15.0,
                                color: custThemeColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: CustomText(
                                  txtTitle: taskListModel.title,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  maxLine: 2,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ),
                              taskListModel.isExpand
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: CustomText(
                                        txtTitle: taskListModel.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        maxLine: 5,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  : Container()
                            ]),
                      ),
                      IconButton(
                        onPressed: () {
                          if (mounted)
                            setState(() {
                              taskListModel.isExpand = !taskListModel.isExpand;
                            });
                        },
                        icon: RotatedBox(
                          quarterTurns: taskListModel.isExpand ? 1 : 3,
                          child: Image.asset(
                            ImgName.back,
                            height: 11.0,
                            width: 7.0,
                            color: custThemeColor,
                          ),
                        ),
                      ),
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
}
