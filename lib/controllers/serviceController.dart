import 'dart:async';
import 'package:beautyShop/models/services.dart';
import 'package:flutter/cupertino.dart';

class ServiceController extends ChangeNotifier {
  bool _isLoading = true;
  List<MyServices> services = [];

  ServiceController() {
    this.getServices();
  }

  bool get isLoading {
    return this._isLoading;
  }

  void addNewService(MyServices service) {
    this.services.insert(0, service);
    notifyListeners();
  }

  void deleteService(MyServices service) {
    this.services.remove(service);
    notifyListeners();
  }

  void getServices() {
    Timer(Duration(milliseconds: 1000), () {
      this.services = MyServices().getServices();
      this._isLoading = false;
      notifyListeners();
    });
  }
}
