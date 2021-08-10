import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/query_model.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

class QueryList extends StatefulWidget {


  @override
  _QueryListState createState() => _QueryListState();
}

class _QueryListState extends State<QueryList> {
  List<QueryModel> queryModelList = [
    QueryModel(
        name: "Amrisha Kaur , 25 years, Female",
        date: "15 feb 2021",
        title: "Patient Status Request",
        description:
            "Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generatorReference site about Lorem",
        status: "Resolved",
        isExpand: false,
        resoultionDate: "16 feb 2021",
        resolutionDescription:
            "patient has been advised IVF and We are waiting patient consent."),
    QueryModel(
        name: "Amrisha Kaur , 25 years, Female",
        date: "15 feb 2021",
        title: "Patient Status Request",
        description:
            "Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generatorReference site about Lorem",
        status: "Resolved",
        isExpand: false,
        resoultionDate: "16 feb 2021",
        resolutionDescription:
            "patient has been advised IVF and We are waiting patient consent."),
    QueryModel(
        name: "Amrisha Kaur , 25 years, Female",
        date: "15 feb 2021",
        title: "Patient Status Request",
        description:
            "Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generatorReference site about Lorem",
        status: "Resolved",
        isExpand: false,
        resoultionDate: "16 feb 2021",
        resolutionDescription:
            "patient has been advised IVF and We are waiting patient consent.")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F8),
      body: SafeArea(
        child: Stack(
          children: [
            //union...
            Image.asset(ImgName.uni, fit: BoxFit.cover),
            //union design...
            Image.asset(ImgName.unionAbove, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  //drawer...
                  IconButton(
                      icon: Image.asset(
                        ImgName.drawer,
                        height: 14.0,
                        width: 16.0,
                      ),
                      onPressed: () {}),
                  //notification label...
                  CustomText(
                    txtTitle: "All Query",
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  Spacer(),
                  CustomText(
                    txtTitle: "Filter",
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  IconButton(
                    icon: Image.asset(
                      ImgName.filter,
                      height: 14.0,
                      width: 16.0,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            //query list...
            ListView.builder(
                padding: EdgeInsets.only(left: 15.0, right: 15, top: 70.0),
                itemCount: queryModelList.length,
                itemBuilder: (context, i) => queryCard(queryModelList[i])),
          ],
        ),
      ),
    );
  }

  Widget queryCard(QueryModel queryModel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
              Container(
                height: 1.0,
                width: 15.0,
                color: Color(0xFF808080),
              ),
              Row(
                children: [
                  CustomText(
                    txtTitle: queryModel.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.black),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(
                        queryModel.isExpand
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                      onPressed: () {
                        if (mounted)
                          setState(() {
                            queryModel.isExpand = !queryModel.isExpand;
                          });
                      })
                ],
              ),
              Row(
                children: [
                  CustomText(
                    txtTitle: queryModel.date,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Colors.black),
                  ),
                  Spacer(),
                  CustomText(
                    txtTitle: "Status: ${queryModel.status}",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Colors.green),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomText(
                  txtTitle: queryModel.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomText(
                  txtTitle: queryModel.description,
                  textOverflow: TextOverflow.ellipsis,
                  maxLine: 3,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Color(0xFF74787A)),
                ),
              ),
              queryModel.isExpand
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomText(
                        txtTitle: "Resolution",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    )
                  : Container(),
              queryModel.isExpand
                  ? Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF2E7EC),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 1.0,
                              width: 15.0,
                              color: Color(0xFF808080),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomText(
                                txtTitle: queryModel.resoultionDate,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomText(
                                txtTitle: queryModel.resolutionDescription,
                                textOverflow: TextOverflow.ellipsis,
                                maxLine: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(color: Color(0xFF74787A)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
