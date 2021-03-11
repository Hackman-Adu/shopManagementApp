import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class Utils {
  static const Color kPrimaryColor = Color(0XFFFA13E97);
  static const Color kDarkPrimaryColor = Color(0XFFF280e3b);
  static const String shopName = "Divas Beauty Shop";
  static const String family = "ShipporiMincho-Regular";

  static TextStyle menuTextStyle() {
    return TextStyle(
        color: Colors.black.withOpacity(0.85),
        fontSize: 15,
        fontFamily: family);
  }

  static Widget spinner() {
    return Platform.isAndroid
        ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          )
        : CupertinoActivityIndicator(
            radius: 30,
          );
  }

  static void navigation(
      {@required BuildContext context, @required Widget destination}) {
    // Navigator.of(context).pop();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destination));
  }
}
