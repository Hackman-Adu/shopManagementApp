import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class Utils {
  //constant values
  static const Color kPrimaryColor = Color(0XFFFFC766A);
  static const Color kDarkPrimaryColor = Color(0XFFFca5348);
  static const String shopName = "Divas Beauty Shop";

  static Widget checkBox() {
    return Container(
      height: 25,
      width: 25,
      child: Center(
          child: Icon(
        Icons.done,
        size: 15,
        color: Colors.white,
      )),
      decoration:
          BoxDecoration(color: Utils.kPrimaryColor, shape: BoxShape.circle),
    );
  }

  static void showpinnerDialog({String text, BuildContext context}) {
    Platform.isAndroid
        ? androidLoadingSpinner(context, text: text)
        : iOSLoadingSpinner(context, text: text);
  }

  static Widget moreIcon() {
    return Platform.isAndroid ? Icon(Icons.more_vert) : Icon(Icons.more_horiz);
  }

//platform specific loading spinner
  static Widget spinner() {
    return Platform.isAndroid
        ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(kPrimaryColor),
          )
        : CupertinoActivityIndicator(
            radius: 15,
          );
  }

  static String ghanaCedi() {
    return "GHC";
  }

  static String getDateTime(String date) {
    var format = new DateFormat('MMMM dd, yyyy hh:mm:ss a');
    return format.format(DateTime.parse(date));
  }

  static Widget bottomText({Color color = Colors.white}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 30),
      child: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Text(
          "Divas Beauty Shop Management\nSystem. (Office Use Only)",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10, color: color),
        ),
      )),
      width: double.infinity,
    );
  }

//platform specific action alert(Yes or No Alert)
  static Future<bool> actionAlert({
    BuildContext context,
    String title,
    String content,
  }) {
    return Platform.isAndroid
        ? showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("No"),
                  )
                ],
              );
            })
        : showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text("Yes"),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("No"),
                  )
                ],
              );
            });
  }

//platform specific simple alert(With just Okay Button)
  static simpleAlert({
    BuildContext context,
    String title,
    String content,
  }) {
    Platform.isAndroid
        ? showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(color: kPrimaryColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Okay"),
                  )
                ],
              );
            })
        : showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Okay"),
                  )
                ],
              );
            });
  }

//android loadingDialog spinner
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

  static showSnackBar(GlobalKey<ScaffoldMessengerState> key, String content,
      {int duration = 500}) {
    key.currentState.showSnackBar(SnackBar(
      content: Text(content),
      duration: Duration(milliseconds: duration),
    ));
  }

//custom floating action button
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

//iOSloadingDialog spinner
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

//static method to handle page navigation across the app
  static navigation(
      {@required BuildContext context, @required Widget destination}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destination));
  }

  static String getInitials(String name) {
    var array = name.trim().split(' ');
    var first = '';
    var last = '';
    if (array.length > 1) {
      first = array[0];
      last = array[array.length - 1];
      return first[0].toUpperCase() + last[0].toUpperCase();
    } else {
      return name[0].toUpperCase();
    }
  }
}
