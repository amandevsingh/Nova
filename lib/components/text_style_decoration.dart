import 'package:flutter/material.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';

// overline : 10.0
// caption  : 12.0
// bodytext1: 14.0
// bodytext2: 16.0
// headline1: 18.0
// headline2: 20.0
// headline3: 22.0
// headline4: 24.0
// headline5: 26.0
// headline6: 28.0

class TextStyleDecoration {
  // App Default font...
  static const String fontFamily = FontStyle.commonFont;

  // Get Text theme...
  static TextTheme get lightTheme => TextTheme(
        overline: _overline, // 10.0
        caption: _caption, // 12.0
        bodyText1: _body1, // 14.0
        bodyText2: _body2, // 16.0
        headline1: _headline1, // 18.0
        headline2: _headline2, // 20.0
        headline3: _headline3, // 22.0
        headline4: _headline4, // 24.0
        headline5: _headline5, // 26.0
        headline6: _headline6, // 28.0
        subtitle1:
            _subTitle, // 14.0 this is also used when no style is given to textfield..
        subtitle2: _subHeadline, // 16.0
        button: _button, // 14.0
      );

  static final _overline = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
  );

  static final _caption = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle _body1 = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static final _body2 = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline1 = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline2 = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline3 = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 22.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline4 = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline5 = TextStyle(
    fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 26.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline6 = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 28.0,
    fontWeight: FontWeight.w400,
  );

  static final _subTitle = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static final _subHeadline = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static final _button = TextStyle(
    fontFamily: fontFamily,
    color: custThemeColor,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get hintTextStyle => TextStyle(
      color: Color(0xFF838485), fontSize: 18.0, fontWeight: FontWeight.w400);

  static TextStyle get labelTextStyle => TextStyle(
      color: Color(0xFF343C54), fontSize: 18.0, fontWeight: FontWeight.w400);
}
