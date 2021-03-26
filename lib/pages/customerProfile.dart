import 'package:flutter/material.dart';
import 'package:beautyShop/models/customers.dart';
import 'package:beautyShop/utils/utils.dart';
import 'dart:async';

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
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(this.customer.image),
        ),
        Positioned(
            top: 17,
            right: -10,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: customer.isActive ? Colors.green : Colors.redAccent,
                  shape: BoxShape.circle),
            )),
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
                      TextStyle(fontSize: 17, color: Utils.kDarkPrimaryColor),
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
          size: 23,
          color: Utils.kPrimaryColor,
        ),
        SizedBox(
          width: 10,
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
              style: TextStyle(fontSize: 16, color: Utils.kDarkPrimaryColor),
            ),
          ],
        )
      ],
    );
  }

  TextStyle optionTextStyle() {
    return TextStyle(fontSize: 17, color: Utils.kDarkPrimaryColor);
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
        leading: Icon(Icons.phone),
        title: Text(
          "Call",
          style: optionTextStyle(),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.of(context).pop();
        },
        leading: Icon(Icons.email),
        title: Text(
          "Send Email",
          style: optionTextStyle(),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.of(context).pop();
        },
        leading: Icon(Icons.message_rounded),
        title: Text(
          "Send SMS",
          style: optionTextStyle(),
        ),
      ),
      Divider(),
      ListTile(
        onTap: () {
          Navigator.of(context).pop();
        },
        leading: Icon(Icons.edit),
        title: Text(
          "Edit Profile",
          style: optionTextStyle(),
        ),
      )
    ];
  }

  List<Widget> buildItems() {
    return [
      itemSpacer(),
      buildItemRow("Customer Status", customer.isActive ? "Active" : "InActive",
          Icons.perm_identity_rounded),
      itemSpacer(),
      Divider(),
      itemSpacer(),
      buildItemRow(
          "Customer ID", customer.customerID, Icons.perm_identity_rounded),
      itemSpacer(),
      Divider(),
      itemSpacer(),
      buildItemRow("Residential Address", customer.address, Icons.location_on),
      itemSpacer(),
      Divider(),
      itemSpacer(),
      buildItemRow("Telephone", customer.telephone, Icons.phone),
      itemSpacer(),
      Divider(),
      itemSpacer(),
      buildItemRow(
          "Last Serviced", customer.lastPurchase, Icons.calendar_today_rounded)
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
