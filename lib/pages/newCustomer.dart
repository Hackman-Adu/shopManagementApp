import 'package:beautyShop/controllers/customersController.dart';
import 'package:beautyShop/pages/customerImages.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:beautyShop/widgets/borderTextField.dart';
import 'package:flutter/material.dart';
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
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  Customers customer = new Customers();
  String customerImage = "";

  Widget spacer({double height = 27}) {
    return SizedBox(
      height: height,
    );
  }

//generating inputfields for the add new customer form
  List<Widget> generateInputFields() {
    return [
      Consumer<CustomersControllers>(
        builder: (context, controller, child) {
          return AllBorderField(
            hint: "Customer ID",
            label: "Customer ID",
            isReadOnly: true,
            controller: new TextEditingController(
                text: controller.customers.length + 1 > 9
                    ? 'CUS0${controller.customers.length + 1}'
                    : "CUS00${controller.customers.length + 1}"),
            onSaved: (value) {
              this.customer.customerID = value;
            },
          );
        },
      ),
      this.spacer(),
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
        type: TextInputType.emailAddress,
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
        type: TextInputType.phone,
        label: "Telephone (+233)",
        onSaved: (value) {
          this.customer.telephone = value;
        },
        validator: (value) {
          if (value.trim() == '') {
            return "Telephone is required";
          } else if (value.trim().length != 9) {
            return "Invalid mobile number";
          } else {
            return null;
          }
        },
      ),
      this.spacer(),
      AllBorderField(
        action: TextInputAction.done,
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
      CustomButton(
        hasIcon: true,
        onClicked: this.customerImage == ''
            ? () async {
                var image = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChooseImage()));
                setState(() {
                  this.customerImage = image ?? '';
                });
              }
            : () {
                setState(() {
                  this.customerImage = '';
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Image removed"),
                  elevation: 20,
                  backgroundColor: Utils.kPrimaryColor,
                  duration: Duration(milliseconds: 500),
                ));
              },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(this.customerImage == '' ? "Add Image" : 'Image added'),
              SizedBox(width: 7),
              Icon(Icons.add_a_photo)
            ],
          ),
        ),
      ),
      this.spacer(),
      Consumer<CustomersControllers>(builder: (context, controller, child) {
        return CustomButton(
          text: "Save",
          onClicked: () {
            if (this.formKey.currentState.validate()) {
              this.formKey.currentState.save();
              this.customer.image = this.customerImage;
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

//header
  Widget header() {
    return Row(
      children: [
        SizedBox(width: 8.5),
        Icon(Icons.person_add_rounded,
            size: 45, color: Utils.kPrimaryColor.withOpacity(0.75)),
        Text(
          "Add New Customer",
          style: TextStyle(
              fontSize: 17, color: Utils.kPrimaryColor.withOpacity(0.75)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (this.formKey.currentState.validate()) {
            return Utils.actionAlert(
                context: context,
                title: "Information Not Saved",
                content:
                    "The information you have provided will not be saved.\n\nDo you want to leave the this page?");
          } else {
            return true;
          }
        },
        child: Scaffold(
            key: this.scaffoldkey,
            appBar: AppBar(
              title: Text("New Customer"),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  this.header(),
                  SizedBox(
                    height: 25,
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
            )));
  }
}
