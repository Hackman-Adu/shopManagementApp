import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final Widget leadingIcon;
  final Widget trailingIcon;
  final String placeholder;
  final Function onSaved;
  final bool hasTrailingIcon;
  final TextInputType type;
  final TextInputAction action;
  final isPassword;
  CustomFormField(
      {this.leadingIcon,
      this.trailingIcon,
      this.placeholder,
      this.onSaved,
      this.type = TextInputType.text,
      this.isPassword = false,
      this.action,
      this.hasTrailingIcon = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffff5f5f5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.black.withOpacity(0.2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leadingIcon ?? Center(),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: TextFormField(
              style: TextStyle(fontSize: 17),
              onSaved: this.onSaved,
              keyboardType: this.type,
              obscureText: this.isPassword,
              textInputAction: this.action,
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 15),
                  border: InputBorder.none,
                  hintText: placeholder),
            )),
            hasTrailingIcon ? trailingIcon : Center()
          ],
        ),
      ),
    );
  }
}
