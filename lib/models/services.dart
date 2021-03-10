import 'package:flutter/material.dart';

class MyServices {
  String serviceName;
  String serviceIcon;
  MyServices({this.serviceName, this.serviceIcon});

  List<MyServices> getServices() {
    return [
      MyServices(
          serviceName: "Makeup", serviceIcon: 'assets/images/makeup.png'),
      MyServices(
          serviceName: "Braiding", serviceIcon: 'assets/images/makeup.png'),
      MyServices(
          serviceName: "Wig Caps", serviceIcon: 'assets/images/makeup.png'),
      MyServices(serviceName: "Nails", serviceIcon: 'assets/images/makeup.png'),
      MyServices(
          serviceName: "Manicure", serviceIcon: 'assets/images/makeup.png'),
      MyServices(
          serviceName: "Pedicure", serviceIcon: 'assets/images/makeup.png'),
      MyServices(
          serviceName: "Fixing Wig", serviceIcon: 'assets/images/makeup.png'),
      MyServices(
          serviceName: "Photoshoot", serviceIcon: 'assets/images/makeup.png')
    ];
  }
}
