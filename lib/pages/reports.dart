import 'package:beautyShop/controllers/customersController.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:beautyShop/widgets/reportTabs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Summary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SummaryState();
  }
}

class SummaryState extends State<Summary> {
  List<ReportTabs> tabs = ReportTabs().getTabs();
  int selectedIndex = 0;
  bool isLoading = true;

  Widget customersReportCard({String title, Color color}) {
    return Consumer<CustomersControllers>(
      builder: (context, controller, child) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: color,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 5),
            child: Column(
              children: [
                Text(
                  title == "Males"
                      ? controller.numberOfMales.toString()
                      : controller.numberOfFemales.toString(),
                  style: TextStyle(fontSize: 50, color: Colors.white),
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white.withOpacity(0.75)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget customersPage() {
    return Row(
      children: [
        Expanded(
            child: this.customersReportCard(
                title: "Males", color: Utils.kPrimaryColor)),
        SizedBox(width: 5),
        Expanded(
            child: this.customersReportCard(
                title: "Females", color: Utils.kDarkPrimaryColor))
      ],
    );
  }

  Widget tabsButtons() {
    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reports"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 17, horizontal: 7),
          child: Column(children: [
            this.tabsButtons(),
            SizedBox(height: 20),
            this.selectedIndex == 0 ? this.customersPage() : Container()
          ]),
        ));
  }
}
