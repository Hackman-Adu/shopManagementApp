import 'package:beautyShop/controllers/customersController.dart';
import 'package:beautyShop/pages/addPayment.dart';
import 'package:flutter/material.dart';
import 'package:beautyShop/models/customers.dart';
import 'package:beautyShop/utils/utils.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class CustomerProfile extends StatefulWidget {
  final Customers customer;
  CustomerProfile({this.customer});
  @override
  State<StatefulWidget> createState() {
    return CustomerProfileState(customer: this.customer);
  }
}

class CustomerProfileState extends State<CustomerProfile> {
  final Customers customer;
  bool isLoading = true;
  CustomerProfileState({this.customer});
  Widget buildProfileImage() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        this.customer.image != ''
            ? CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(this.customer.image),
              )
            : CircleAvatar(
                backgroundColor: Utils.kPrimaryColor,
                radius: 35,
                child: Center(
                  child: Text(
                    Utils.getInitials(customer.fullName),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
      ],
    );
  }

  Widget buildHeader() {
    return Card(
      elevation: 25,
      shadowColor: Colors.black.withOpacity(0.15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        child: Row(
          children: [
            this.buildProfileImage(),
            SizedBox(
              width: 17,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.fullName.toUpperCase(),
                  style:
                      TextStyle(fontSize: 15, color: Utils.kDarkPrimaryColor),
                ),
                Text(
                  customer.emailAddress,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                )
              ],
            )),
            IconButton(
              splashRadius: 20,
              onPressed: () {
                this.viewOptions(context);
              },
              icon: Icon(
                Icons.more_vert,
                color: Utils.kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemRow(
    String title,
    String value,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Utils.kPrimaryColor,
        ),
        SizedBox(
          width: 13,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              value.toUpperCase(),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }

  TextStyle optionTextStyle() {
    return TextStyle(fontSize: 15, color: Utils.kDarkPrimaryColor);
  }

  Widget customerProfileHeader() {
    return Card(
      elevation: 0,
      color: Color(0xffff5f5f5),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
          child: Row(
            children: [
              Text(
                "Customer Profile".toUpperCase(),
                style: TextStyle(
                  fontSize: 15,
                  color: Utils.kDarkPrimaryColor.withOpacity(0.75),
                ),
              )
            ],
          )),
    );
  }

  List<Widget> options() {
    return [
      ListTile(
        onTap: () {
          Navigator.of(context).pop();
        },
        leading: Icon(
          Icons.phone,
          size: 20,
        ),
        title: Text(
          "Call",
          style: optionTextStyle(),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.of(context).pop();
        },
        leading: Icon(
          Icons.email,
          size: 20,
        ),
        title: Text(
          "Send Email",
          style: optionTextStyle(),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.of(context).pop();
        },
        leading: Icon(
          Icons.message_rounded,
          size: 20,
        ),
        title: Text(
          "Send SMS",
          style: optionTextStyle(),
        ),
      ),
      Divider(),
      ListTile(
        onTap: () {
          Navigator.of(context).pop();
          Utils.navigation(
              context: context,
              destination:
                  AddNewPayment(route: 'profile', customer: this.customer));
        },
        leading: Icon(
          Icons.payment_rounded,
          size: 20,
        ),
        title: Text(
          "Add Payment",
          style: optionTextStyle(),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.of(context).pop();
        },
        leading: Icon(Icons.edit, size: 20),
        title: Text(
          "Edit Profile",
          style: optionTextStyle(),
        ),
      ),
      ListTile(
        onTap: () async {
          Navigator.of(context).pop();
          this.removingCustomer(customer);
        },
        leading: Icon(
          Icons.delete,
          size: 20,
        ),
        title: Text(
          "Delete Customer",
          style: optionTextStyle(),
        ),
      )
    ];
  }

  void removingCustomer(Customers customer) async {
    var value = await Utils.actionAlert(
        content:
            "Deleting this customer will remove customer from all other records.\nDo you want to delete customer?",
        title: "Delete Customer",
        context: context);
    if (value) {
      Utils.showpinnerDialog(context: context, text: "Deleting customer...");
      Timer(Duration(milliseconds: 1000), () {
        Navigator.of(context).pop();
        setState(() {
          Provider.of<CustomersControllers>(context, listen: false)
              .deleteCustomer(customer);
        });
        Navigator.pop(context);
      });
    }
  }

  List<Widget> buildItems() {
    return [
      buildItemRow(
          "Customer ID", customer.customerID, Icons.perm_identity_rounded),
      itemSpacer(),
      Divider(),
      buildItemRow("Gender", customer.gender, Icons.person),
      itemSpacer(),
      Divider(),
      itemSpacer(),
      buildItemRow("Email Address", customer.emailAddress, Icons.email),
      Divider(),
      itemSpacer(),
      buildItemRow("Residential Address", customer.address, Icons.location_on),
      itemSpacer(),
      Divider(),
      itemSpacer(),
      buildItemRow("Telephone 1", customer.telephone, Icons.phone),
      itemSpacer(),
      Divider(),
      itemSpacer(),
      buildItemRow(
          "Telephone 2",
          customer.telephone2.trim() != ''
              ? "+233 " + customer.telephone2
              : 'Not provided',
          Icons.phone),
      itemSpacer(),
      Divider(),
      itemSpacer(),
    ];
  }

  Widget itemSpacer() {
    return SizedBox(
      height: 15,
    );
  }

  void viewOptions(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(),
        context: context,
        builder: (context) {
          return Container(
            child: Wrap(
              children: [...this.options()],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: isLoading == false
            ? ListView(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                children: [
                  this.buildHeader(),
                  Divider(),
                  customerProfileHeader(),
                  Card(
                    elevation: 25,
                    shadowColor: Colors.black.withOpacity(0.15),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 7),
                      child: Column(
                        children: [...this.buildItems()],
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: Utils.spinner(),
              ));
  }
}
