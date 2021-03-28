import 'dart:async';

import 'package:beautyShop/controllers/customersController.dart';
import 'package:beautyShop/controllers/paymentController.dart';
import 'package:beautyShop/models/payments.dart';
import 'package:beautyShop/pages/addPayment.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManagePayments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManagePaymentState();
  }
}

class ManagePaymentState extends State<ManagePayments> {
  Widget top(number) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Row(
          children: [
            Text(
              "RECEIVED PAYMENTS ($number)",
              style: TextStyle(color: Utils.kDarkPrimaryColor),
            ),
            Spacer(),
            IconButton(
                splashRadius: 20,
                icon:
                    Icon(Icons.filter_list_rounded, color: Utils.kPrimaryColor),
                onPressed: () {})
          ],
        ),
      ),
    );
  }

  void showOptions(Payments payment, customer) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewPayment(
                                    route: "update",
                                    selectedpayment: payment,
                                    customer: customer,
                                  )));
                    },
                    leading: Icon(Icons.edit),
                    title: Text("Edit Payment")),
                ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      this.deletingPayment(payment);
                    },
                    leading: Icon(Icons.delete),
                    title: Text("Delete Payment"))
              ],
            ),
          );
        });
  }

  void deletingPayment(Payments payment) async {
    var controller = Provider.of<PaymentController>(context, listen: false);
    var value = await Utils.actionAlert(
        context: context,
        content:
            "Deleting this payment will remove payment permanently from your records.\n\nDo you want to continue?",
        title: "Delete Payment");
    if (value) {
      Utils.showpinnerDialog(context: context, text: "Deleting payment");
      Timer(Duration(milliseconds: 500), () {
        controller.deletePayment(payment);
        Navigator.of(context).pop();
      });
    }
  }

  Widget bottom() {
    return Consumer<PaymentController>(
      builder: (context, controller, child) {
        return Card(
          color: Utils.kPrimaryColor,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "TOTAL",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    Utils.ghanaCedi() +
                        ' ' +
                        controller.totalPayment.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<PaymentController>(context);
    var customer = Provider.of<CustomersControllers>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Payments"),
          actions: [
            Padding(
                padding: EdgeInsets.all(10),
                child: RawMaterialButton(
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Text(
                              "New Payment",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.add),
                          ],
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewPayment(
                                    route: '',
                                  )));
                    }))
          ],
        ),
        body: controller.isLoading == false
            ? controller.payments.length > 0
                ? ListView(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 3),
                    children: [
                      this.top(controller.payments.length),
                      SizedBox(height: 5),
                      ...controller.payments.map((payment) {
                        var index = customer.customers.indexWhere((element) {
                          return element.customerID == payment.customerID;
                        });
                        var cus = customer.customers.where((cus) {
                          return cus.customerID == payment.customerID;
                        }).toList();

                        return Column(children: [
                          ListTile(
                            onTap: () {
                              if (index != -1) {
                                this.showOptions(payment, cus[0]);
                              } else {
                                Utils.simpleAlert(
                                    context: context,
                                    content: "Customer has been deleted",
                                    title: "Customer Not Found");
                              }
                            },
                            isThreeLine: true,
                            title: index != -1
                                ? Text(
                                    cus[0].fullName,
                                    style: TextStyle(fontSize: 17),
                                  )
                                : Text("Customer Not Found",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.redAccent)),
                            trailing: Text(
                              Utils.ghanaCedi() + payment.amount,
                              style: TextStyle(
                                  fontSize: 17.5,
                                  color: Utils.kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        Utils.getDateTime(payment.date) + '\n',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Utils.kDarkPrimaryColor)),
                                TextSpan(
                                    text: payment.service,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Utils.kDarkPrimaryColor))
                              ]),
                            ),
                          ),
                          Divider()
                        ]);
                      }).toList(),
                      SizedBox(height: 10),
                      this.bottom(),
                      Divider()
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No Payment Recorded",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Utils.kPrimaryColor)),
                        Text("Start recording payments",
                            style: TextStyle(
                                fontSize: 14,
                                color: Utils.kPrimaryColor.withOpacity(0.65)))
                      ],
                    ),
                  )
            : Center(
                child: Utils.spinner(),
              ));
  }
}
