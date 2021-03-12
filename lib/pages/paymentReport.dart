import 'package:flutter/material.dart';

class PaymentReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PaymentReportState();
  }
}

class PaymentReportState extends State<PaymentReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Report"),
      ),
      body: Center(
        child: Text("Payment Report"),
      ),
    );
  }
}
