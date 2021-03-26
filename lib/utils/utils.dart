import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class Utils {
  //constant values
  static const Color kPrimaryColor = Color(0XFFF7f0a49);
  static const Color kDarkPrimaryColor = Color(0XFFF4c062c);
  static const String shopName = "Divas Beauty Shop";
  static const String family = "ShipporiMincho-Regular";

//static style for the menu(Navigation drawer) items
  static TextStyle menuTextStyle() {
    return TextStyle(
      color: Colors.black.withOpacity(0.80),
      fontSize: 15,
    );
  }

  static void showpinnerDialog({String text, BuildContext context}) {
    Platform.isAndroid
        ? androidLoadingSpinner(context, text: text)
        : iOSLoadingSpinner(context, text: text);
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

//platform specific action alert(Yes or No Alert)
  static Future<bool> actionAlert(
      {BuildContext context,
      String title,
      String content,
      bool hasTwoActions = false}) {
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
    Function okayPressed,
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
                    onPressed: okayPressed,
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
                    onPressed: okayPressed,
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
  static void navigation(
      {@required BuildContext context, @required Widget destination}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destination));
  }
}
