import 'package:beautyShop/widgets/reportTabs.dart';
import 'package:flutter/material.dart';

class Summary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SummaryState();
  }
}

class SummaryState extends State<Summary> {
  List<ReportTabs> tabs = ReportTabs().getTabs();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reports"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 17, horizontal: 4),
          child: Column(
            children: [
              Row(
                children: [
                  ...this.tabs.map((tab) {
                    var index = this.tabs.indexOf(tab);
                    return ReportTab(
                        function: () {
                          setState(() {
                            this.selectedIndex = index;
                          });
                        },
                        tab: tab,
                        index: index,
                        selectedIndex: this.selectedIndex);
                  }).toList()
                ],
              )
            ],
          ),
        ));
  }
}
