import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Models/Notifications.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ));
    return GraphQLProvider(
        child: Scaffold(
          backgroundColor: Color(0xFFF7F7F7),
          body: SafeArea(
            child: Stack(
              children: [
                Image.asset(
                  ImgName.uni,
                ),
                Row(
                                                children: [
                                                  Image.asset(
                                                      ImgName.unionAbove,
                                                      height: 75.0,
                                                      width: 50.0,
                                                      fit: BoxFit.fill),
                                                  Spacer(),
                                                  Image.asset(
                                                      ImgName.unionAboveB,
                                                      height: 75.0,
                                                      width: 60.0,
                                                      fit: BoxFit.fill),
                                                ],
                                              ),
                Query(
                    options: QueryOptions(
                        document: gql(getNotificationQuery),
                        pollInterval: Duration(minutes: 5)),
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      Notifications notifcationList;
                      if (result.data != null) {
                        notifcationList = Notifications.fromJson(result.data);
                      }

                      return Center(
                        child: result.hasException
                            ? Text("")
                            : result.isLoading
                                ? CircularProgressIndicator()
                                : ListView.builder(
                                    padding: EdgeInsets.only(
                                        left: 15.0, right: 15, top: 70.0),
                                    itemCount: notifcationList
                                        ?.notificationList?.length,
                                    itemBuilder: (context, i) =>
                                        notificationCard(notifcationList
                                            ?.notificationList[i])),
                      );
                    }),
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
                        txtTitle: "Notification",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        client: client);
  }

  Widget notificationCard(NotificationList notificationList) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 100.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 3.0),
                  blurRadius: 6,
                  color: Color(0xFFDBDBDB)),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 1.0,
                width: 15.0,
                color: custThemeColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: CustomText(
                  txtTitle: notificationList.date,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Color(0xFFC52068), fontSize: 12.0),
                ),
              ),
              CustomText(
                txtTitle: notificationList.title,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              CustomText(
                txtTitle: notificationList.body,
                maxLine: 2,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 10.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
