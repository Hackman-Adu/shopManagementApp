import 'package:beautyShop/controllers/customersController.dart';
import 'package:beautyShop/controllers/paymentController.dart';
import 'package:beautyShop/controllers/serviceController.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static List<SingleChildWidget> providers() {
    return [
      ChangeNotifierProvider<CustomersControllers>(
          create: (BuildContext context) => CustomersControllers()),
      ChangeNotifierProvider<ServiceController>(
          create: (BuildContext context) => ServiceController()),
      ChangeNotifierProvider<PaymentController>(
          create: (BuildContext context) => PaymentController())
    ];
  }
}
