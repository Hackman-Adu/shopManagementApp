import 'package:flutter/material.dart';

class Utils {
  static const Color kPrimaryColor = Color(0XFFFA13E97);
  static const String shopName = "Divas Beauty Shop";

  static TextStyle menuTextStyle() {
    return TextStyle(color: Colors.black.withOpacity(0.85), fontSize: 14);
  }

  static void navigation(
      {@required BuildContext context, @required Widget destination}) {
    Navigator.of(context).pop();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destination));
  }
}
