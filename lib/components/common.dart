import 'package:flutter/material.dart';
import 'package:flutter_auth/components/img_color_static_strings.dart';


InputDecoration searchFieldInputDecoration(
    {required String hintText, required BuildContext context}) {
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
          ?.copyWith(color: Colors.white.withOpacity(0.32)),
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

InputDecoration custInputDecoration(
    {required String hintText, required BuildContext context, Widget? suffix}) {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: Theme.of(context)
          .textTheme
          .bodyText1
          ?.copyWith(fontSize: 13.0, color: Color(0xFFAEADAD)),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Color(0xFFBF8CA4),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Color(0xFFBF8CA4),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Color(0xFFBF8CA4),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: custThemeColor.withOpacity(0.6),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Color(0xFFBF8CA4),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Color(0xFFBF8CA4),
        ),
      ));
}

Widget commonButton(
    {required BuildContext context,
    required String btnLabel,
    required void Function() onPressed}) {
  return Container(
    height: 55,
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          custThemeColor,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        btnLabel,
      ),
    ),
  );
}
