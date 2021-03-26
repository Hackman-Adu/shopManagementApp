import 'package:beautyShop/controllers/customersController.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static List<SingleChildWidget> providers() {
    return [
      ChangeNotifierProvider<CustomersControllers>(
          create: (BuildContext context) => CustomersControllers())
    ];
  }
}
