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
      color: Colors.black.withOpacity(0.80),
      fontSize: 15,
    );
  }

  static Widget spinner() {
    return Platform.isAndroid
        ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(kPrimaryColor),
          )
        : CupertinoActivityIndicator(
            radius: 15,
          );
  }

  static androidLoadingSpinner(BuildContext context, {String text}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(text)
              ],
            ),
          );
        });
  }

  static showSnackBar(GlobalKey<ScaffoldState> key, String content,
      {int duration = 500}) {
    key.currentState.showSnackBar(SnackBar(
      content: Text(content),
      duration: Duration(milliseconds: duration),
    ));
  }

  static Widget customFloatingButton(
      {BuildContext context, Function function, String text}) {
    return FloatingActionButton.extended(
      backgroundColor: Utils.kPrimaryColor,
      onPressed: function,
      label: Row(
        children: [
          Container(
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 17,
                  color: Utils.kDarkPrimaryColor,
                ),
              ),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              height: 30,
              width: 30),
          SizedBox(width: 7),
          Text(text)
        ],
      ),
    );
  }

  static iOSLoadingSpinner(BuildContext context, {String text}) {
    showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoActivityIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text(text)
              ],
            ),
          );
        });
  }

  static void navigation(
      {@required BuildContext context, @required Widget destination}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destination));
  }
}
