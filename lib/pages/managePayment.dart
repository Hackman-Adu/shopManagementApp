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
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<PaymentController>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Payments"),
        ),
        floatingActionButton: Utils.customFloatingButton(
            context: context,
            text: "Add New Payment",
            function: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNewPayment()));
            }),
        body: controller.isLoading == false
            ? controller.payments.length > 0
                ? Container()
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
