import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../models/customers.dart';

class CustomersControllers extends ChangeNotifier {
  bool _isLoading = true;
  List<Customers> customers = [];

  CustomersControllers() {
    this.getCustomers();
  }

  bool get isLoading {
    return this._isLoading;
  }

  int get numberOfMales {
    return this
        .customers
        .where((customer) {
          return customer.gender.toLowerCase() == "male";
        })
        .toList()
        .length;
  }

  int get numberOfFemales {
    return this
        .customers
        .where((customer) {
          return customer.gender.toLowerCase() == "female";
        })
        .toList()
        .length;
  }

  void addNewCustomers(Customers customer) {
    this.customers.insert(0, customer);
    notifyListeners();
  }

  void deleteCustomer(Customers customer) {
    this.customers.remove(customer);
    notifyListeners();
  }

  void getCustomers() {
    Timer(Duration(milliseconds: 1000), () {
      this.customers = Customers().getCustomers();
      this._isLoading = false;
      notifyListeners();
    });
  }
}
