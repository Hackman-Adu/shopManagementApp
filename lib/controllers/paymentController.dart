import 'dart:async';
import 'package:beautyShop/models/payments.dart';
import 'package:flutter/cupertino.dart';

class PaymentController extends ChangeNotifier {
  bool _isLoading = true;
  List<Payments> payments = [];

  PaymentController() {
    this.getPayments();
  }

  bool get isLoading {
    return this._isLoading;
  }

  void addNewPayment(Payments payment) {
    this.payments.insert(0, payment);
    notifyListeners();
  }

  void deletePayment(Payments payment) {
    this.payments.remove(payment);
    notifyListeners();
  }

  void getPayments() {
    Timer(Duration(milliseconds: 1000), () {
      this.payments = Payments().getPayments();
      this._isLoading = false;
      notifyListeners();
    });
  }
}
