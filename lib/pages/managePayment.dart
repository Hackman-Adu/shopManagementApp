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
  bool isLoading = true;
  Widget header() {
    return Row(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("Received Payments",
                style: TextStyle(
                    fontSize: 18,
                    color: Utils.kDarkPrimaryColor,
                    fontFamily: Utils.family))),
        SizedBox(
          width: 7,
        ),
        Text(
          "(${this.payments.length})",
          style: TextStyle(fontSize: 17, color: Colors.grey),
        )
      ],
    );
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
                  height: 25,
                ),
                header(),
                SizedBox(
                  height: 21,
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
