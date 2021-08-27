import 'dart:core';

import 'dart:core';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }

  static void showFlushbarToast(
      String message, BuildContext context, int type) {
    Flushbar(
      title: type == 0
          ? 'Error'
          : type == 1
              ? 'Warning'
              : 'Success',
      message: message,
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundGradient: type == 0
          ? LinearGradient(colors: [Colors.red, Colors.red[100]])
          : type == 1
              ? LinearGradient(colors: [Colors.black, Colors.black26])
              : LinearGradient(colors: [Colors.teal, Colors.tealAccent]),
      duration: Duration(seconds: 2),
      isDismissible: true,
      boxShadows: [
        BoxShadow(
          color: Colors.blue[800],
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
    )..show(context);
  }
}
