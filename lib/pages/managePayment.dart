import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:beautyShop/models/payments.dart';
import 'package:beautyShop/models/customers.dart';
import 'dart:async';

class ManagePayments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManagePaymentState();
  }
}

class ManagePaymentState extends State<ManagePayments> {
  List<Payments> payments = Payments().getPayments();
  List<Customers> customers = Customers().getCustomers();
  String defaultFilter = "All";
  bool isLoading = true;

  //initializing values for the filter options
  List<String> filterValues = [
    'All',
    'Today',
    'Yesterday',
    'This Week',
    'Last Week',
    'This Month',
    'Last Month'
  ];

  //header widget
  Widget header() {
    return Row(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("Received Payments - ${this.defaultFilter}",
                style: TextStyle(
                    fontSize: 15,
                    color: Utils.kDarkPrimaryColor,
                    fontFamily: Utils.family))),
        SizedBox(
          width: 7,
        ),
        Text(
          "(${this.payments.length})",
          style: TextStyle(fontSize: 17, color: Colors.grey),
        ),
        Spacer(),
        IconButton(
          onPressed: () async {
            var value = await this.showFilterOptions(context);
            print(value);
          },
          splashRadius: 20,
          color: Utils.kPrimaryColor,
          icon: Icon(Icons.sort),
        ),
        SizedBox(width: 16),
      ],
    );
  }

//displaying the bottom sheet
  Future<String> showFilterOptions(BuildContext context) async {
    return await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(17), topLeft: Radius.circular(17))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      "Filter Payments",
                      style: TextStyle(fontFamily: Utils.family, fontSize: 17),
                    ),
                  ),
                  ...this.filterValues.map((value) {
                    String filter = value;
                    return ListTile(
                        onTap: () {
                          setState(() {
                            this.setState(() {
                              this.defaultFilter = filter;
                            });
                            Navigator.of(context).pop(this.defaultFilter);
                          });
                        },
                        trailing: filter == this.defaultFilter
                            ? Container(
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: Icon(
                                    Icons.done,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Utils.kPrimaryColor,
                                    shape: BoxShape.circle),
                              )
                            : Text(''),
                        title: Text(value));
                  }).toList()
                ],
              ),
            );
          });
        });
  }

  @override
  void initState() {
    super.initState();
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
        title: Text("Payments"),
      ),
      body: isLoading == false
          ? ListView(
              children: [
                SizedBox(
                  height: 5,
                ),
                header(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(),
                ),
                SizedBox(
                  height: 13,
                ),
                ...this.payments.map((payment) {
                  var customerName =
                      this.customers[this.payments.indexOf(payment)].fullName;
                  var customerImage =
                      this.customers[this.payments.indexOf(payment)].image;
                  return Column(
                    children: [
                      ListTile(
                          onTap: () {},
                          title: Text(
                            customerName,
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black.withOpacity(0.85)),
                          ),
                          subtitle: Text(
                            payment.date ?? '',
                            style: TextStyle(color: Utils.kPrimaryColor),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(customerImage),
                          ),
                          trailing: Container(
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: Utils.kPrimaryColor),
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "GHC " + payment.amount,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: Utils.family),
                              ),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Divider(),
                      )
                    ],
                  );
                }).toList()
              ],
            )
          : Center(child: Utils.spinner()),
    );
  }
}
