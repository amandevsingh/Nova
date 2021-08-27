import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Models/DoctorContentList.dart';
import 'package:flutter_auth/Models/UserDetails.dart';
import 'package:flutter_auth/Screens/auth/profile_screen.dart';
import 'package:flutter_auth/Screens/auth/terms_privacy_screen.dart';
import 'package:flutter_auth/Screens/auth/welcome_screen.dart';
import 'package:flutter_auth/Screens/home/general_query.dart';
import 'package:flutter_auth/Screens/home/notification_screen.dart';
import 'package:flutter_auth/Screens/home/patient_detail.dart';
import 'package:flutter_auth/Screens/home/patient_listing.dart';
import 'package:flutter_auth/Screens/home/query_list.dart';
import 'package:flutter_auth/Screens/home/refer_patient.dart';
import 'package:flutter_auth/Screens/home/whats_new_from_nova.dart';
import 'package:flutter_auth/api/api.dart';
import 'package:flutter_auth/components/cust_image.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'CommonWebView.dart';

enum DrawerItem {
  Whats_New_From_Nova,
  Notification,
  All_Query,
  Settings,
  Terms_Condition,
  LogOut
}

class HomeScreen extends StatefulWidget {
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer timer;
  TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  UserDetails userDetails = UserDetails();
  List<String> iconList = [
    ImgName.whatNew,
    ImgName.notification,
    ImgName.allQuery,
    ImgName.setting,
    ImgName.termNCondition,
    ImgName.logOut
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
    FirebaseMessaging.instance
        .getToken(
      vapidKey: "BGpdLRs......",
    )
        .then((value) async {
      final deviceInfoPlugin = new DeviceInfoPlugin();
      try {
        timer = Timer.periodic(Duration(seconds: 3), (Timer t) async {
          if (Platform.isAndroid) {
            var build = await deviceInfoPlugin.androidInfo;
            var reults = await clientSend.query(QueryOptions(
              document: gql(addNotificationToken),
              variables: {
                "device_id": build.androidId,
                "os": "Android",
                "platform": "app",
                "token": value
              },
            ));
            if (reults != null) timer.cancel();
            print(reults);
          } else if (Platform.isIOS) {
            var data = await deviceInfoPlugin.iosInfo;
            var reults = await clientSend.query(QueryOptions(
              document: gql(addNotificationToken),
              variables: {
                "device_id": data.identifierForVendor,
                "os": "iOS",
                "platform": "app",
                "token": value
              },
            ));
            if (reults != null) timer.cancel();
            print(reults);
          }
        });
      } on Exception {}
    });
  }

  SharedPreferences sharedPrefs;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ));

    return GraphQLProvider(
        child: Query(
            options: QueryOptions(
                document: gql(getTasksQuery),
                variables: {"phone": sharedPrefs?.getString(MOBILE_NUMBER)},
                pollInterval: Duration(seconds: 5)),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              // if (result.data != null) {
              //   userDetails = UserDetails.fromJson(result.data);
              //   if (userDetails.orgUsers.isNotEmpty) {
              //     sharedPrefs.setString(USER_ID, userDetails?.orgUsers[0].id);
              //   }
              // }

              return Scaffold(
                key: _key,
                drawerEnableOpenDragGesture: false,
                drawer: Drawer(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Container(
                          height: 125.0,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Color(0xFF821541),
                                Color(0xFF7E135C)
                              ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                          child: Center(
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Color(0xFFC52068),
                                child: Image.asset(
                                  ImgName.patient,
                                  color: Colors.white,
                                  height: 15.0,
                                  width: 15.0,
                                ),
                              ),
                              title: CustomText(
                                txtTitle: "Dr. " +
                                    upperCaseFirst(userDetails?.orgUsers != null
                                        ? userDetails?.orgUsers[0]?.name
                                        : ""),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(color: Colors.white),
                              ),
                              subtitle: CustomText(
                                txtTitle: "Gurgaon, Haryana",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.white),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProfileScreen(
                                              orgUsers:
                                                  userDetails?.orgUsers != null
                                                      ? userDetails?.orgUsers[0]
                                                      : "")));
                                },
                              ),
                            ),
                          ),
                        ),
                        //tiles...
                        Expanded(
                          child: Container(
                              color: Color(0xFFE5D0DE),
                              child: ListView.separated(
                                  itemBuilder: (context, i) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                iconList[i],
                                                height: 20.0,
                                                width: 20.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: CustomText(
                                                  txtTitle: i == 4
                                                      ? "Terms & Conditions"
                                                          .toUpperCase()
                                                      : describeEnum(DrawerItem
                                                              .values[i])
                                                          .replaceAll("_", " ")
                                                          .toUpperCase(),
                                                  onPressed: () async {
                                                    if (_key.currentState
                                                        .isDrawerOpen) {
                                                      _key.currentState
                                                          .openEndDrawer();
                                                    }
                                                    if (i == 0) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  WhatsNewFromNova()));
                                                    } else if (i == 1) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  NotificationScreen()));
                                                    } else if (i == 2) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  QueryList()));
                                                    } else if (i == 3) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  QueryList()));
                                                    } else if (i == 4) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  TermsAndConditionsScreen(
                                                                      title:
                                                                          "Terms of Service")));
                                                    } else if (i == 5) {
                                                      Cognito.signOut();
                                                      var prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      await prefs?.setBool(
                                                          IS_LOGGED_IN, false);
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  WelcomeScreen()));
                                                    }
                                                  },
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .copyWith(
                                                          color: Color(
                                                              0xFFC52068)),
                                                ),
                                              )
                                            ]),
                                      ),
                                  separatorBuilder: (context, i) => Divider(
                                        color: Color(0xFFE1C7D3),
                                      ),
                                  itemCount: DrawerItem.values.length)),
                        )
                      ],
                    ),
                  ),
                ),
                floatingActionButton: Hero(
                  tag: "query",
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => GeneralQueryScreen(),
                          ),
                        );
                      },
                      child: Image.asset(
                        ImgName.msg,
                        height: 50.0,
                        width: 50.0,
                      ),
                    ),
                  ),
                ),
                body: Center(
                    child: result.hasException
                        ? Text("")
                        : result.isLoading
                            ? CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                child: SafeArea(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFF7F8FA),
                                            Color(0xFFEBEBEB),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight),
                                    ),
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Stack(children: [
                                              Container(
                                                height: 265.0,
                                                width: double.infinity,
                                                child: Image.asset(
                                                    ImgName.union,
                                                    fit: BoxFit.cover),
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
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //drawer icon , nova icon , notify icon.....
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            right: 10.0,
                                                            top: 10.0),
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            _key.currentState
                                                                .openDrawer();
                                                          },
                                                          icon: Image.asset(
                                                            ImgName.drawer,
                                                            width: 16.0,
                                                            height: 14.0,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 0.0),
                                                          child: Image.asset(
                                                            ImgName
                                                                .novaIconWhite,
                                                            width: 50.0,
                                                            height: 18.0,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.of(context).push(
                                                                PageRouteBuilder(
                                                                    pageBuilder:
                                                                        (context,
                                                                            animation,
                                                                            anotherAnimation) {
                                                                      return NotificationScreen();
                                                                    },
                                                                    transitionDuration:
                                                                        Duration(
                                                                            milliseconds:
                                                                                500),
                                                                    transitionsBuilder: (context,
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
                                                                          position:
                                                                              Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation),
                                                                          child:
                                                                              child,
                                                                        ),
                                                                        //     SizeTransition(
                                                                        //   sizeFactor:
                                                                        //       animation,
                                                                        //   child:
                                                                        //       child,
                                                                        //   axisAlignment:
                                                                        //       0.0,
                                                                        // ),
                                                                      );
                                                                    }));
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder: (ctx) =>
                                                            //         NotificationScreen(),
                                                            //   ),
                                                            // );
                                                          },
                                                          child: Badge(
                                                            badgeContent:
                                                                CustomText(
                                                              txtTitle: "2",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .overline
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                            badgeColor: Color(
                                                                0xFF80144A),
                                                            position: BadgePosition
                                                                .topEnd(
                                                                    top: -7.0,
                                                                    end: -4.0),
                                                            child: Image.asset(
                                                              ImgName.notify,
                                                              height: 21.0,
                                                              width: 21.0,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  //good morning label , dr name...
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            top: 15.0),
                                                    child: CustomText(
                                                      txtTitle: greeting(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: CustomText(
                                                      txtTitle: "Dr. " +
                                                          upperCaseFirst((userDetails
                                                                          ?.orgUsers
                                                                          ?.length ??
                                                                      0) >
                                                                  0
                                                              ? userDetails
                                                                  ?.orgUsers[0]
                                                                  ?.name
                                                              : ""),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                  //search field...
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Visibility(
                                                        visible: true,
                                                        child: SizedBox(
                                                          height: 42.0,
                                                          child: TextFormField(
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2
                                                                .copyWith(
                                                                    color:
                                                                        custThemeColor),
                                                            cursorColor:
                                                                Colors.white,
                                                            cursorHeight: 22.0,
                                                            controller:
                                                                _searchController,
                                                            decoration: searchFieldInputDecoration(
                                                                hintText:
                                                                    "Patient Name or number"
                                                                        .toUpperCase()),
                                                          ),
                                                        )),
                                                  ),

                                                  //track my patientnt and refer patient...
                                                  Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 50.0,
                                                              right: 50.0,
                                                              top: 30.0),
                                                      child: Row(
                                                        children: [
                                                          commonPart(
                                                              ImgName.track,
                                                              "Track\nMy Patients"
                                                                  .toUpperCase(),
                                                              () {
                                                            Navigator.of(context).push(
                                                                PageRouteBuilder(
                                                                    pageBuilder:
                                                                        (context,
                                                                            animation,
                                                                            anotherAnimation) {
                                                                      return PatientListing();
                                                                    },
                                                                    transitionDuration:
                                                                        Duration(
                                                                            milliseconds:
                                                                                700),
                                                                    transitionsBuilder: (context,
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
                                                                            SizeTransition(
                                                                          sizeFactor:
                                                                              animation,
                                                                          child:
                                                                              child,
                                                                          axisAlignment:
                                                                              0.0,
                                                                        ),
                                                                      );
                                                                    }));
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder: (ctx) =>
                                                            //         PatientListing(),
                                                            //   ),
                                                            // );
                                                          }),
                                                          Spacer(),
                                                          commonPart(
                                                              ImgName.patient,
                                                              "Refer\nPatient"
                                                                  .toUpperCase(),
                                                              () {
                                                            Navigator.of(context).push(
                                                                PageRouteBuilder(
                                                                    pageBuilder:
                                                                        (context,
                                                                            animation,
                                                                            anotherAnimation) {
                                                                      return ReferPatientScreen(
                                                                          userDetails:
                                                                              userDetails);
                                                                    },
                                                                    transitionDuration:
                                                                        Duration(
                                                                            milliseconds:
                                                                                700),
                                                                    transitionsBuilder: (context,
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
                                                                            SizeTransition(
                                                                          sizeFactor:
                                                                              animation,
                                                                          child:
                                                                              child,
                                                                          axisAlignment:
                                                                              0.0,
                                                                        ),
                                                                      );
                                                                    }));
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder: (ctx) =>
                                                            //         ReferPatientScreen(
                                                            //             userDetails:
                                                            //                 userDetails),
                                                            //   ),
                                                            // );
                                                          })
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]),
                                            //whats new from nova today list...
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30.0,
                                                  left: 15.0,
                                                  right: 15.0),
                                              child: Row(
                                                children: [
                                                  CustomText(
                                                    txtTitle:
                                                        "What's New From Nova Today",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                  Spacer(),
                                                  Image.asset(
                                                    ImgName.metroFlow,
                                                    height: 12.0,
                                                    width: 9.0,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Query(
                                                options: QueryOptions(
                                                    document:
                                                        gql(doctorContent),
                                                    pollInterval:
                                                        Duration(seconds: 5)),
                                                builder: (QueryResult result,
                                                    {VoidCallback refetch,
                                                    FetchMore fetchMore}) {
                                                  if (result.data != null) {
                                                    DoctorContentList
                                                        doctorContentList =
                                                        DoctorContentList
                                                            .fromJson(
                                                                result.data);
                                                    return Expanded(
                                                      child: ListView.builder(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      15.0,
                                                                  vertical:
                                                                      15.0),
                                                          itemCount:
                                                              doctorContentList
                                                                  ?.dataUserContent
                                                                  ?.length,
                                                          itemBuilder: (context,
                                                                  i) =>
                                                              detailCard(
                                                                  doctorContentList
                                                                          ?.dataUserContent[
                                                                      i])),
                                                    );
                                                  } else {
                                                    return SizedBox(
                                                      height: 200,
                                                    );
                                                  }
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
              );
            }),
        client: client);
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour >= 3 && hour < 12) {
      return 'Good Morning,';
    }
    if (hour >= 12 && hour < 16) {
      return 'Good Afternoon,';
    }
    if (hour >= 16 && hour < 21) {
      return 'Good Evening,';
    }
    return 'Good Night,';
  }

  String upperCaseFirst(String s) =>
      (s ?? '').length < 1 ? '' : s[0].toUpperCase() + s.substring(1);

  Widget detailCard(DataUserContent dataUserContent) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return CommonWebView(
                        articleID: dataUserContent.id,
                        title: dataUserContent.title);
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
              //   builder: (BuildContext context) => CommonWebView(
              //       articleID: dataUserContent.id,
              //       title: dataUserContent.title))
              );
        }, // Handle your callback
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: 90.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0.0, 3.0),
                      blurRadius: 6,
                      color: Color(0xFFDBDBDB)),
                ]),
            child: Row(
              children: [
                Container(
                    height: 90.0,
                    child: CustImage(
                      imgURL: dataUserContent.imgUrl,
                      height: 90.0,
                      width: 90.0,
                      assetString: ImgName.doc,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 9.0, bottom: 9.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        textOverflow: TextOverflow.ellipsis,
                        txtTitle: dataUserContent.title,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w300, fontSize: 11.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CustomText(
                          textOverflow: TextOverflow.ellipsis,
                          txtTitle: dataUserContent.description,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 9.0, fontWeight: FontWeight.w300),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CustomText(
                          txtTitle: isTest(dataUserContent.createdAt),
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Color(0xFF8D8D8D),
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        width: 15.0,
                        color: custThemeColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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

  Widget commonPart(String imgName, String text, Function onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 106.0,
        width: 122.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(0.0, 3.0),
                blurRadius: 6,
                color: Color(0xFFDBDBDB)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgName,
              height: 40.0,
              width: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: CustomText(
                txtTitle: text,
                style: Theme.of(context).textTheme.bodyText1,
                align: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
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
}
