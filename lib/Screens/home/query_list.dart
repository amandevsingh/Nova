import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/QueryListModel.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class QueryList extends StatefulWidget {
  QueryList({Key key}) : super(key: key);

  @override
  _QueryListState createState() => _QueryListState();
}

class _QueryListState extends State<QueryList> {
  QueryListModel queryListModel = QueryListModel();

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        child: Scaffold(
          backgroundColor: Color(0xFFF7F7F8),
          body: SafeArea(
            child: Stack(
              children: [
                //union...
                Image.asset(ImgName.uni, fit: BoxFit.cover),
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 15.0),
                  child: Row(
                    children: [
                      //drawer...
                      IconButton(
                        icon: Image.asset(
                          ImgName.drawer,
                          height: 14.0,
                          width: 16.0,
                        ),
                        onPressed: () {},
                      ),

                      //notification label...
                      CustomText(
                        txtTitle: "All Query",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      Spacer(),
                      CustomText(
                        txtTitle: "Filter",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      IconButton(
                        icon: Image.asset(
                          ImgName.filter,
                          height: 18.0,
                          width: 27.0,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                //query list...
                Query(
                    options: QueryOptions(
                        document: gql(getDoctorQuery),
                        pollInterval: Duration(minutes: 5)),
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (result.data != null) {
                        if (queryListModel?.queryNotesUserQueries == null)
                          queryListModel = QueryListModel.fromJson(result.data);
                      }

                      return Center(
                          child: result.hasException
                              ? Text("")
                              : result.isLoading
                                  ? CircularProgressIndicator()
                                  : ListView.builder(
                                      padding: EdgeInsets.only(
                                          left: 15.0, right: 15, top: 70.0),
                                      itemCount: queryListModel
                                          ?.queryNotesUserQueries?.length,
                                      itemBuilder: (context, i) => queryCard(
                                          queryListModel
                                              ?.queryNotesUserQueries[i])));
                    }),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      color: Colors.transparent, size: 22.0),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
        client: client);
  }

  Widget queryCard(QueryNotesUserQueries queryModel) {
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
                  Visibility(
                      visible: queryModel?.referral?.name != null,
                      child: CustomText(
                        txtTitle: "${queryModel?.referral?.name}, ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black),
                      )),
                  CustomText(
                    txtTitle:
                        "${queryModel?.referral?.age}yrs, ${queryModel?.referral?.gender}",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.black),
                  ),
                  Visibility(visible: true, child: Spacer()),
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
                    txtTitle: isTest(queryModel?.referral?.referredDate ?? ""),
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.black),
                  ),
                  Spacer(),
                  CustomText(
                    txtTitle: "Status: ${queryModel.status ?? ""}",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.green),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomText(
                  txtTitle: queryModel.title ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomText(
                  txtTitle: queryModel.userQueryNotes.length > 0
                      ? queryModel.userQueryNotes[0].remarks ?? ""
                      : "",
                  textOverflow: TextOverflow.ellipsis,
                  maxLine: 3,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Color(0xFF74787A)),
                ),
              ),
              queryModel.isExpand && queryModel.userQueryNotes.length > 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomText(
                        txtTitle: "Resolution",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    )
                  : Container(),
              queryModel.isExpand && queryModel.userQueryNotes.length > 1
                  ? Container(
                      width: double.infinity,
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
                                txtTitle: isTest(
                                    queryModel?.referral?.referredDate ?? ""),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomText(
                                txtTitle: queryModel.userQueryNotes.length > 1
                                    ? queryModel.userQueryNotes[1].remarks ?? ""
                                    : "",
                                textOverflow: TextOverflow.ellipsis,
                                maxLine: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Color(0xFF74787A)),
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

  String isTest(String value) {
    if (value.isNotEmpty) {
      var parts = value.split('T');
      var prefix = parts[0].trim();
      var inputDate = DateFormat('yyyy-MM-dd').parse(prefix);
      var outputFormat = DateFormat('dd-MMM-yyyy');
      return outputFormat.format(inputDate);
    } else {
      return "                    ";
    }
  }
}
