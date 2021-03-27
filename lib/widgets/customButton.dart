import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onClicked;
  final Widget child;
  final bool hasIcon;

  CustomButton({this.text, this.hasIcon = false, this.onClicked, this.child});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      height: 55,
      minWidth: double.infinity,
      textColor: Colors.white,
      color: Utils.kDarkPrimaryColor,
      onPressed: this.onClicked,
      child: !this.hasIcon
          ? Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 15),
              ),
            )
          : child,
    );
  }
}
