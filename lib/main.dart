import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/perscription_requested.dart';
import 'package:flutter_auth/components/constants.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';
import 'package:flutter_auth/components/text_style_decoration.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          canvasColor: Colors.transparent,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          unselectedWidgetColor: custThemeColor,
          textTheme: TextStyleDecoration.lightTheme),
      home: PerscriptionRequested(),
    );
  }
}
