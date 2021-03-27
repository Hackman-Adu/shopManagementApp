import 'package:beautyShop/pages/home.dart';
import 'package:beautyShop/pages/managePayment.dart';
import 'package:beautyShop/pages/manageServices.dart';
import 'package:beautyShop/pages/reports.dart';
import 'package:beautyShop/pages/settings.dart';
import 'package:flutter/material.dart';

class MenuItems {
  String name;
  IconData icon;
  Widget destination;
  MenuItems({this.name, this.destination, this.icon});

  List<MenuItems> menus() {
    return [
      MenuItems(name: "Customers", destination: Home(), icon: Icons.people),
      MenuItems(
          destination: ManageServices(),
          name: "Services",
          icon: Icons.home_repair_service_rounded),
      MenuItems(
          name: "Payments",
          destination: ManagePayments(),
          icon: Icons.money_rounded),
      MenuItems(
          name: "Reports",
          destination: Summary(),
          icon: Icons.sticky_note_2_rounded),
      MenuItems(
          name: "Settings", destination: SettingsPage(), icon: Icons.settings),
      MenuItems(name: "Logout", icon: Icons.logout)
    ];
  }
}
