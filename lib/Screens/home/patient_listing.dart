import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/patient_detail_model.dart';
import 'package:flutter_auth/Screens/home/patient_detail.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

enum ListType { Active, In_Active }

class PatientListing extends StatefulWidget {
  PatientListing({Key key}) : super(key: key);

  @override
  _PatientListingState createState() => _PatientListingState();
}

class _PatientListingState extends State<PatientListing> {
  ListType selectListType = ListType.Active;

  TextEditingController searchController = TextEditingController();

  static List<PatientDetailModel> patientList = [
    PatientDetailModel(
      name: "Amrisha Kaur",
      age: "25",
      gender: "F",
      phone: "9843216666",
      referredOn: "05 jan 2021",
      latestStatus: "On-Going",
      latestDate: "10 june 2021",
      status: "Active",
    ),
    PatientDetailModel(
      name: "Sheetal Shirke",
      age: "34",
      gender: "F",
      phone: "9843216666",
      referredOn: "05 jan 2021",
      latestStatus: "Completed",
      latestDate: "10 june 2021",
      status: "Active",
    ),
    PatientDetailModel(
      name: "Swati Rana",
      age: "25",
      gender: "F",
      phone: "9843216666",
      referredOn: "05 jan 2021",
      latestStatus: "On-Going",
      latestDate: "10 june 2021",
      status: "Active",
    ),
    PatientDetailModel(
      name: "Jacky Samuel",
      age: "25",
      gender: "F",
      phone: "9843216666",
      referredOn: "05 jan 2021",
      latestStatus: "Stopped",
      latestDate: "10 june 2021",
      status: "Active",
    ),
    PatientDetailModel(
      name: "Shruti Sinha",
      age: "25",
      gender: "F",
      phone: "9843216666",
      referredOn: "05 jan 2021",
      latestStatus: "",
      latestDate: "10 june 2021",
      status: "In Active",
    ),
    PatientDetailModel(
      name: "Lovely Singh",
      age: "25",
      gender: "F",
      phone: "9843216666",
      referredOn: "05 jan 2021",
      latestStatus: "",
      latestDate: "10 june 2021",
      status: "In Active",
    )
  ];
  List<PatientDetailModel> displayList =
      patientList.where((element) => element.status == "Active").toList();

  @override
  void dispose() {
    searchController.dispose();
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
        backgroundColor: Color(0xFFF1F1F2),
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

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, right: 15.0, left: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                ImgName.drawer,
                                width: 16.0,
                                height: 14.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Image.asset(
                                  ImgName.novaIconWhite,
                                  width: 50.0,
                                  height: 18.0,
                                ),
                              ),
                              Spacer(),
                              Image.asset(
                                ImgName.msgWhite,
                                height: 25.0,
                                width: 25.0,
                              )
                            ],
                          ),
                          //search field...
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 25.0),
                            child: SizedBox(
                              height: 42.0,
                              child: TextFormField(
                                  controller: searchController,
                                  cursorColor: Colors.white,
                                  cursorHeight: 22.0,
                                  //controller: _searchController,
                                  decoration: searchFieldInputDecoration(
                                      context: context,
                                      hintText: "Patient Name or number"
                                          .toUpperCase()),
                                  onChanged: (_) {
                                    if (mounted) setState(() {});
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            activeInActiveButton(ListType.Active),
                            SizedBox(
                              width: 15.0,
                            ),
                            activeInActiveButton(ListType.In_Active)
                          ],
                        ),
                      ),
                searchController.text.isNotEmpty
                    ? Container()
                    : SizedBox(
                        height: 500.0,
                        child: ListView.builder(
                            itemCount: displayList.length,
                            itemBuilder: (context, i) =>
                                patientCard(displayList[i])),
                      )
              ],
            ),
          ),
        ),
      ),
    );
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
            ? patientList
                .where((element) => element.status == "Active")
                .toList()
            : patientList
                .where((element) => element.status != "Active")
                .toList();
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
                        txtTitle: "5",
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

  Widget patientCard(PatientDetailModel patientDetailModel) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => PatientDetail(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 96.0,
          width: 343.0,
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
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImgName.patient,
                  height: 42.0,
                  width: 42.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
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
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          CustomText(
                            txtTitle:
                                "Referred on: ${patientDetailModel.referredOn}",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CustomText(
                            txtTitle:
                                "Latest Status: ${patientDetailModel.latestDate}",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          CustomText(
                            txtTitle: patientDetailModel.latestStatus ?? "",
                            style: Theme.of(context).textTheme.caption.copyWith(
                                color: patientDetailModel.latestStatus ==
                                        "Completed"
                                    ? Colors.green
                                    : patientDetailModel.latestStatus ==
                                            "Stopped"
                                        ? Colors.red
                                        : custThemeColor),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchActiveWidget() {
    final activeSearchList = patientList
        .where((element) =>
            element.name
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) &&
            element.status == "Active")
        .toList();
    final inActivesearchList = patientList
        .where((element) =>
            element.name
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) &&
            element.status != "Active")
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
      PatientDetailModel patientDetailModel, ListType listType) {
    return SizedBox(
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
                      "${patientDetailModel.name}, ${patientDetailModel.age}yrs, ${patientDetailModel.gender}",
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
                        txtTitle: patientDetailModel.phone,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      CustomText(
                        txtTitle:
                            "Referred on: ${patientDetailModel.referredOn}",
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
    );
  }
}
