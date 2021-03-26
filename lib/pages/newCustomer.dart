import 'dart:io';
import 'package:beautyShop/controllers/customersController.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:beautyShop/widgets/borderTextField.dart';
import 'package:flutter/material.dart';
import "package:beautyShop/widgets/textField.dart";
import 'package:beautyShop/widgets/customButton.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../models/customers.dart';

class AddNewCustomer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNewCustomerState();
  }
}

class AddNewCustomerState extends State<AddNewCustomer> {
  var scaffoldkey = GlobalKey<ScaffoldMessengerState>();
  var formKey = GlobalKey<FormState>();
  Customers customer = new Customers();
  Widget spacer() {
    return SizedBox(
      height: 21,
    );
  }

//generating inputfields for the add new customer form
  List<Widget> generateInputFields() {
    return [
      AllBorderField(
        hint: "Enter customer fullname",
        label: "Customer Fullname",
        validator: (value) {
          if (value.trim() == '') {
            return "Fullname is required";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          this.customer.fullName = value;
        },
      ),
      this.spacer(),
      AllBorderField(
        hint: "Enter customer email address",
        label: "Customer Email Address",
        validator: (value) {
          if (value.trim() == '') {
            return "Email address is required";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          this.customer.emailAddress = value;
        },
      ),
      this.spacer(),
      AllBorderField(
        hint: "Telephone (+233)",
        label: "Telephone (+233)",
        onSaved: (value) {
          this.customer.telephone = value;
        },
        validator: (value) {
          if (value.trim() == '') {
            return "Telephone is required";
          } else {
            return null;
          }
        },
      ),
      this.spacer(),
      AllBorderField(
        hint: "Residential Address",
        label: "Residential Address",
        onSaved: (value) {
          this.customer.address = value;
        },
        validator: (value) {
          if (value.trim() == '') {
            return "Residential address is required";
          } else {
            return null;
          }
        },
      ),
      this.spacer(),
      Consumer<CustomersControllers>(builder: (context, controller, child) {
        return CustomButton(
          text: "Save",
          onClicked: () {
            if (this.formKey.currentState.validate()) {
              this.formKey.currentState.save();
              this.customer.image = "assets/images/girl6.jpg";
              Utils.showpinnerDialog(
                  context: context, text: "Adding new customer...");
              Timer(Duration(milliseconds: 500), () {
                controller.addNewCustomers(this.customer);
                print(this.customer.fullName);
                Navigator.of(context).pop();
                Utils.simpleAlert(
                    title: "New Customer Added",
                    context: context,
                    content: "Customer successfully added");
                this.formKey.currentState.reset();
              });
            }
          },
        );
      }),
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
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Form(
                    key: this.formKey,
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
