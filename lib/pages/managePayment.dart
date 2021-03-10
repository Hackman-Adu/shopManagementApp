import 'package:flutter/material.dart';

class ManagePayments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManagePaymentState();
  }
}

class ManagePaymentState extends State<ManagePayments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Payments"),
      ),
    );
  }
}
