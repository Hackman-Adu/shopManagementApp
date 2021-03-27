import 'dart:async';

import 'package:beautyShop/menuItems.dart';
import 'package:beautyShop/pages/login.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashBoardState();
  }
}

class DashBoardState extends State<DashBoard> {
  List<MenuItems> menus = MenuItems().menus();
  bool isGrid = true;

  void logout() async {
    var value = await Utils.actionAlert(
        title: "Logout", context: context, content: "Do you want to logout?");
    if (value) {
      Utils.showpinnerDialog(context: context, text: "Logging out...");
      Timer(Duration(milliseconds: 500), () {
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    }
  }

  Widget top() {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        child: Row(
          children: [
            Text(
              "QUICK ACCESS",
              style: TextStyle(color: Utils.kDarkPrimaryColor),
            ),
            Spacer(),
            IconButton(
                splashRadius: 20,
                icon: Icon(
                  !this.isGrid ? Icons.view_module_rounded : Icons.list,
                  color: Utils.kDarkPrimaryColor,
                ),
                onPressed: () {
                  setState(() {
                    this.isGrid = !this.isGrid;
                  });
                })
          ],
        ),
      ),
    );
  }

  Widget grid() {
    return GridView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: this.menus.length,
        gridDelegate:
            SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 300),
        itemBuilder: (context, index) {
          var menu = this.menus[index];
          return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                if (menu.name != "Logout") {
                  Utils.navigation(
                      context: context, destination: menu.destination);
                } else {
                  this.logout();
                }
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 25,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(menu.icon,
                              size: 45, color: Utils.kDarkPrimaryColor),
                          SizedBox(height: 5),
                          Text(
                            menu.name,
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black.withOpacity(0.75)),
                          )
                        ],
                      ),
                    ),
                  )));
        });
  }

  Widget listview() {
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        ...this.menus.map((menu) {
          return ListTile(
              onTap: () {
                if (menu.name != "Logout") {
                  Utils.navigation(
                      context: context, destination: menu.destination);
                } else {
                  this.logout();
                }
              },
              trailing: Icon(
                Icons.chevron_right_outlined,
                color: Utils.kDarkPrimaryColor,
              ),
              leading:
                  Icon(menu.icon, size: 30, color: Utils.kDarkPrimaryColor),
              title: Text(menu.name, style: TextStyle(fontSize: 16)));
        }).toList()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            Utils.shopName,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(children: [
            this.top(),
            this.isGrid ? this.grid() : this.listview(),
            Utils.bottomText(color: Utils.kPrimaryColor)
          ]),
        ));
  }
}
