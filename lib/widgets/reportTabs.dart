import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';

class ReportTab extends StatelessWidget {
  final ReportTabs tab;
  final Function function;
  final int index;
  final int selectedIndex;
  ReportTab({this.tab, this.index, this.selectedIndex, this.function});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: this.function,
      child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: tab.title == "Customers"
                  ? BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))
                  : BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
              border: Border.all(width: 1, color: Utils.kDarkPrimaryColor),
              color: this.selectedIndex == index
                  ? Utils.kDarkPrimaryColor
                  : Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(tab.title,
                  style: TextStyle(
                      fontSize: 15,
                      color: this.selectedIndex == index
                          ? Colors.white
                          : Utils.kDarkPrimaryColor)),
            ],
          )),
    ));
  }
}

class ReportTabs {
  String title;
  ReportTabs({this.title});

  List<ReportTabs> getTabs() {
    return [ReportTabs(title: "Customers"), ReportTabs(title: "Payments")];
  }
}
