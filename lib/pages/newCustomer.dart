import 'dart:io';
import 'package:beautyShop/utils/utils.dart';
import 'package:flutter/material.dart';
import "package:beautyShop/widgets/textField.dart";
import 'package:beautyShop/widgets/customButton.dart';
import 'dart:async';

class AddNewCustomer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNewCustomerState();
  }
}

class AddNewCustomerState extends State<AddNewCustomer> {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  Widget spacer() {
    return SizedBox(
      height: 17,
    );
  }

  List<Widget> generateInputFields() {
    return [
      CustomFormField(
        placeholder: "Fullname",
        action: TextInputAction.next,
        type: TextInputType.text,
        leadingIcon: Icon(
          Icons.person,
          color: Utils.kDarkPrimaryColor,
        ),
        hasTrailingIcon: false,
      ),
      this.spacer(),
      CustomFormField(
        action: TextInputAction.next,
        type: TextInputType.emailAddress,
        placeholder: "Email Address",
        leadingIcon: Icon(
          Icons.email,
          color: Utils.kDarkPrimaryColor,
        ),
        hasTrailingIcon: false,
      ),
      this.spacer(),
      CustomFormField(
        action: TextInputAction.next,
        type: TextInputType.phone,
        placeholder: "Telephone (+233)",
        leadingIcon: Icon(
          Icons.phone,
          color: Utils.kDarkPrimaryColor,
        ),
        hasTrailingIcon: false,
      ),
      this.spacer(),
      CustomFormField(
        action: TextInputAction.next,
        type: TextInputType.text,
        placeholder: "Residential Address",
        leadingIcon: Icon(
          Icons.location_city,
          color: Utils.kDarkPrimaryColor,
        ),
        hasTrailingIcon: false,
      ),
      this.spacer(),
      CustomFormField(
        placeholder: "Service type",
        leadingIcon: Icon(
          Icons.dns,
          color: Utils.kDarkPrimaryColor,
        ),
        hasTrailingIcon: false,
      ),
      this.spacer(),
      CustomButton(
        text: "Save",
        onClicked: () {
          Platform.isIOS
              ? Utils.iOSLoadingSpinner(context, text: "Processing...")
              : Utils.androidLoadingSpinner(context, text: "Processing...");
          Timer(Duration(milliseconds: 500), () {
            Navigator.of(context).pop();
            Utils.showSnackBar(
                this.scaffoldkey, "New customer successfully added");
          });
        },
      ),
      this.spacer(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: this.scaffoldkey,
        appBar: AppBar(
          title: Text("Add New Customer"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 13),
                width: double.infinity,
                child: Text(
                  "All fields are required",
                  style: TextStyle(fontSize: 14, color: Utils.kPrimaryColor),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                  child: Form(
                    child: Column(
                      children: [...this.generateInputFields()],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
