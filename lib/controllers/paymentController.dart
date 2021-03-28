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

  double get totalPayment {
    double total = 0;
    this.payments.forEach((payment) {
      double d = double.parse(payment.amount);
      total += d;
    });
    return total;
  }

  void addNewPayment(Payments payment) {
    this.payments.insert(0, payment);
    notifyListeners();
  }

  void updatePayment(Payments payment) {
    var index = this.getUpdatePaymentIndex(payment);
    this.payments[index] = payment;
    notifyListeners();
  }

  int getUpdatePaymentIndex(Payments payment) {
    return this.payments.indexOf(payment);
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
