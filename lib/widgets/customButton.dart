import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onClicked;

  CustomButton({this.text, this.onClicked});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      height: 50,
      minWidth: double.infinity,
      textColor: Colors.white,
      color: Utils.kDarkPrimaryColor,
      onPressed: this.onClicked,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
