import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/home/add_referal_screen.dart';
import 'package:flutter_auth/Screens/home/general_query.dart';
import 'package:flutter_auth/Screens/home/notification_screen.dart';
import 'package:flutter_auth/Screens/home/patient_detail.dart';
import 'package:flutter_auth/Screens/home/patient_listing.dart';
import 'package:flutter_auth/components/common.dart';
import 'package:flutter_auth/components/cust_image.dart';
import 'package:flutter_auth/components/custom_text.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

enum DrawerItem {
  Whats_New_From_Nova,
  Notification,
  All_Query,
  Settings,
  Terms_Condition,
  LogOut
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

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
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ));
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
                        colors: [Color(0xFF821541), Color(0xFF7E135C)],
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
                      txtTitle: "Dr. Manju Singh",
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
                      onPressed: () {},
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      iconList[i],
                                      height: 20.0,
                                      width: 20.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: CustomText(
                                        txtTitle:
                                            describeEnum(DrawerItem.values[i])
                                                .replaceAll("_", " ")
                                                .toUpperCase(),
                                        onPressed: () {},
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(color: Color(0xFFC52068)),
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
      floatingActionButton: InkWell(
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFFF7F8FA),
                Color(0xFFEBEBEB),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Stack(children: [
                      Container(
                        height: 265.0,
                        width: double.infinity,
                        child: Image.asset(ImgName.union, fit: BoxFit.cover),
                      ),
                      Image.asset(
                        ImgName.unionAbove,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //drawer icon , nova icon , notify icon.....
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 15.0, top: 20.0),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _key.currentState.openDrawer();
                                  },
                                  icon: Image.asset(
                                    ImgName.drawer,
                                    width: 16.0,
                                    height: 14.0,
                                  ),
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
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => NotificationScreen(),
                                      ),
                                    );
                                  },
                                  child: Badge(
                                    badgeContent: CustomText(
                                      txtTitle: "2",
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline
                                          .copyWith(color: Colors.white),
                                    ),
                                    badgeColor: Color(0xFF80144A),
                                    position: BadgePosition.topEnd(
                                        top: -7.0, end: -4.0),
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
                                const EdgeInsets.only(left: 15.0, top: 25.0),
                            child: CustomText(
                              txtTitle: "Good morning,",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: CustomText(
                              txtTitle: "Dr. Manju Singh",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          //search field...
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              height: 42.0,
                              child: TextFormField(
                                cursorColor: Colors.white,
                                cursorHeight: 22.0,
                                controller: _searchController,
                                decoration: searchFieldInputDecoration(
                                    context: context,
                                    hintText:
                                        "Patient Name or number".toUpperCase()),
                              ),
                            ),
                          ),

                          //track my patientnt and refer patient...
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 50.0, right: 50.0),
                              child: Row(
                                children: [
                                  commonPart(ImgName.track,
                                      "Track\nMy Patients".toUpperCase(), () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => PatientListing(),
                                      ),
                                    );
                                  }),
                                  Spacer(),
                                  commonPart(ImgName.patient,
                                      "Refer\nPatient".toUpperCase(), () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => ReferPatientScreen(),
                                      ),
                                    );
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
                          top: 30.0, left: 15.0, right: 15.0),
                      child: Row(
                        children: [
                          CustomText(
                            txtTitle: "What's New From Nova Today",
                            style: Theme.of(context).textTheme.bodyText1,
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
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15.0),
                          itemCount: 10,
                          itemBuilder: (context, i) => detailCard()),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailCard() {
    return Padding(
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
                  height: 90.0,
                  width: 108.0,
                  assetString: ImgName.doc,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    txtTitle: "What is IVF (in vitro fertilizations) ?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 10.0),
                  ),
                  CustomText(
                    txtTitle:
                        "IVF is the process of fertilizations by\nextracting eggs,",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 10.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: CustomText(
                      txtTitle: "15 May 2021",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Color(0xFF8D8D8D), fontSize: 10.0),
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
    );
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
}
