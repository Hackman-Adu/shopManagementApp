import "package:flutter/material.dart";

class AllBorderField extends StatelessWidget {
  final String hint;
  final String label;
  final bool isReadOnly;
  final Widget suffixIcon;
  final int maxLines;
  final int maxLength;
  final TextInputAction action;
  final TextEditingController controller;
  final Function onTap;
  final Function onSaved;
  final TextInputType type;
  final Function validator;
  final bool isEnabled;
  AllBorderField(
      {this.hint,
      this.label,
      this.isEnabled = true,
      this.action = TextInputAction.next,
      this.isReadOnly = false,
      this.suffixIcon,
      this.maxLength,
      this.maxLines = 1,
      this.controller,
      this.type = TextInputType.text,
      this.onTap,
      this.onSaved,
      this.validator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      keyboardType: type,
      onSaved: onSaved,
      enabled: isEnabled,
      maxLength: maxLength,
      textInputAction: action,
      style: TextStyle(fontSize: 17),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      onTap: onTap,
      readOnly: isReadOnly,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hint,
          border: OutlineInputBorder(),
          labelText: label),
    );
  }
}
