import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';

class Summary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SummaryState();
  }
}

class SummaryState extends State<Summary> {
  int selectedIndex = 0;
  Widget buildTabButton(BuildContext context, String title, Function function,
      Color color, Color textColor) {
    return Expanded(
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Utils.kPrimaryColor.withOpacity(0.34),
          onTap: function,
          child: Card(
            elevation: 0,
            color: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 7),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 17, color: textColor),
                ),
              ),
            ),
          )),
    );
  }

  Widget buildTab() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 7),
        width: double.infinity,
        child: Row(
          children: [
            this.buildTabButton(context, "Customers", () {
              setState(() {
                this.selectedIndex = 0;
              });
            }, selectedIndex == 0 ? Utils.kDarkPrimaryColor : Colors.white,
                selectedIndex == 0 ? Colors.white : Utils.kDarkPrimaryColor),
            SizedBox(
              width: 3,
            ),
            this.buildTabButton(context, "Payments", () {
              setState(() {
                this.selectedIndex = 1;
              });
            }, selectedIndex == 1 ? Utils.kDarkPrimaryColor : Colors.white,
                selectedIndex == 1 ? Colors.white : Utils.kDarkPrimaryColor),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reports"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 17),
          child: Column(
            children: [buildTab()],
          ),
        ));
  }
}
