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
  TextEditingController gender = new TextEditingController(text: '');
  List<String> genderList = ['Male', 'Female'];

  Widget spacer({double height = 27}) {
    return SizedBox(
      height: height,
    );
  }

  void chooseGender() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Wrap(
              children: [
                ...this.genderList.map((g) {
                  return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        this.gender.text = g;
                      },
                      trailing:
                          g == this.gender.text ? Utils.checkBox() : Text(''),
                      title: Text(g));
                }).toList()
              ],
            ),
          );
        });
  }

  Widget choosePhoto() {
    return Padding(
        padding: EdgeInsets.only(left: 13),
        child: Row(children: [
          this.customerImage == ''
              ? this.noImageSelectedAvatar()
              : this.imageSelectedAvatar(),
          SizedBox(width: 5),
          TextButton(
              onPressed: () async {
                if (this.customerImage == '') {
                  var image = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChooseImage()));
                  setState(() {
                    this.customerImage = image ?? this.customerImage;
                  });
                } else {
                  setState(() {
                    this.customerImage = '';
                  });
                }
              },
              child: Row(
                children: [
                  Icon(this.customerImage == '' ? Icons.add : Icons.remove),
                  SizedBox(width: 7),
                  Text(this.customerImage == '' ? "Add Photo" : "Remove Photo")
                ],
              ))
        ]));
  }

  Widget noImageSelectedAvatar() {
    return CircleAvatar(
      backgroundColor: Utils.kDarkPrimaryColor,
      radius: 35,
      child: Center(
        child: Icon(
          Icons.account_circle_rounded,
          size: 25,
        ),
      ),
    );
  }

  Widget imageSelectedAvatar() {
    return CircleAvatar(
      backgroundColor: Utils.kDarkPrimaryColor,
      backgroundImage: AssetImage(this.customerImage),
      radius: 35,
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
            isEnabled: false,
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
        label: "Gender",
        isReadOnly: true,
        suffixIcon: Icon(Icons.arrow_drop_down),
        onTap: () {
          this.chooseGender();
        },
        controller: this.gender,
        validator: (value) {
          if (value.trim() == '') {
            return "Gender is required";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          this.customer.gender = value;
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
        hint: "Telephone 1 (+233)",
        type: TextInputType.phone,
        label: "Telephone 1 (+233)",
        maxLength: 9,
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
        hint: "Telephone 2 (+233)",
        type: TextInputType.phone,
        label: "Telephone 2 (+233) optional",
        maxLength: 9,
        onSaved: (value) {
          this.customer.telephone2 = value;
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
      Consumer<CustomersControllers>(builder: (context, controller, child) {
        return CustomButton(
          text: "Save",
          onClicked: () {
            this.saveCustomerInformation(controller);
          },
        );
      }),
      this.spacer(),
    ];
  }

//saving information
  void saveCustomerInformation(controller) {
    if (this.formKey.currentState.validate()) {
      this.formKey.currentState.save();
      this.customer.image = this.customerImage;
      Utils.showpinnerDialog(context: context, text: "Adding new customer...");
      Timer(Duration(milliseconds: 500), () {
        controller.addNewCustomers(this.customer);
        print(this.customer.fullName);
        Navigator.of(context).pop();
        Utils.simpleAlert(
            title: "New Customer Added",
            context: context,
            content: "Customer successfully added");
        this.formKey.currentState.reset();
        setState(() {
          this.customerImage = '';
        });
      });
    }
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
              title: Text("Add New Customer"),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  this.choosePhoto(),
                  SizedBox(
                    height: 25,
                  ),
                  Card(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7, vertical: 10),
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
