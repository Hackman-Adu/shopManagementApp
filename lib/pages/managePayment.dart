import 'package:beautyShop/controllers/customersController.dart';
import 'package:beautyShop/controllers/paymentController.dart';
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
        padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
        child: Row(
          children: [
            Text(
              "RECEIVED PAYMENTS",
              style: TextStyle(color: Utils.kDarkPrimaryColor),
            ),
            Spacer(),
            Text("($number)")
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<PaymentController>(context);
    var customer = Provider.of<CustomersControllers>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Payments"),
        ),
        floatingActionButton: Utils.customFloatingButton(
            context: context,
            text: "Add New Payment",
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewPayment(
                            route: '',
                          )));
            }),
        body: controller.isLoading == false
            ? controller.payments.length > 0
                ? ListView(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 3),
                    children: [
                      this.top(controller.payments.length),
                      ...controller.payments.map((payment) {
                        var cus = customer.customers.where((cus) {
                          return cus.customerID == payment.customerID;
                        }).toList();

                        return Column(children: [
                          ListTile(
                            isThreeLine: true,
                            title: Text(
                              cus[0].fullName ?? 'Not Found',
                              style: TextStyle(fontSize: 17),
                            ),
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
                      }).toList()
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
