import 'package:beautyShop/pages/managePayment.dart';
import 'package:beautyShop/pages/manageServices.dart';
import 'package:beautyShop/pages/newCustomer.dart';
import 'package:beautyShop/pages/settings.dart';
import 'package:beautyShop/pages/reports.dart';
import 'package:beautyShop/pages/viewCustomers.dart';
import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:beautyShop/models/services.dart';
import 'package:beautyShop/widgets/gridCard.dart';
import 'package:beautyShop/pages/login.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  //list of My Services model
  List<MyServices> services = MyServices().getServices();

//Navigation drawer items
  List<Widget> menuItems() {
    return [
      //header
      UserAccountsDrawerHeader(
        accountEmail: Text(
          "Quality services assured",
          style: TextStyle(color: Colors.white.withOpacity(0.85)),
        ),
        accountName: Text(
          Utils.shopName,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Utils.kPrimaryColor.withOpacity(0.56), BlendMode.multiply),
                image: AssetImage("assets/images/menuBackground.jpg"))),
      ),

      //defining items in the navigation drawer
      ListTile(
        onTap: () {
          //do nothing here close the drawer
          Navigator.of(context).pop();
        },
        title: Text(
          'Home',
          style: Utils.menuTextStyle(),
        ),
        leading: Icon(Icons.home),
      ),
      ListTile(
        onTap: () {
          Navigator.pop(context);
          Utils.navigation(context: context, destination: ManageServices());
        },
        title: Text(
          'Manage Services',
          style: Utils.menuTextStyle(),
        ),
        leading: Icon(Icons.home_repair_service_rounded),
      ),
      ListTile(
        onTap: () {
          Navigator.pop(context);
          Utils.navigation(context: context, destination: ManagePayments());
        },
        title: Text(
          'Manage Payments',
          style: Utils.menuTextStyle(),
        ),
        leading: Icon(Icons.money_rounded),
      ),
      ListTile(
        onTap: () {
          Navigator.pop(context);
          Utils.navigation(context: context, destination: Summary());
        },
        title: Text(
          'Reports',
          style: Utils.menuTextStyle(),
        ),
        leading: Icon(Icons.sticky_note_2_rounded),
      ),
      ListTile(
        onTap: () {
          Navigator.pop(context);
          Utils.navigation(context: context, destination: SettingsPage());
        },
        title: Text(
          'Settings',
          style: Utils.menuTextStyle(),
        ),
        leading: Icon(Icons.settings),
      ),
      ListTile(
        onTap: () async {
          Navigator.of(context).pop();
          bool value = await Utils.actionAlert(
              content: "Do you want to logout?",
              context: context,
              title: "Logout");
          if (value == true) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          }
        },
        title: Text(
          'Logout',
          style: Utils.menuTextStyle(),
        ),
        leading: Icon(Icons.login_outlined),
      ),
    ];
  }

//header widget
  Widget header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categorized Customers",
                style: TextStyle(fontSize: 21, color: Utils.kDarkPrimaryColor),
              ),
              Text(
                "Customers categorized according to services",
                style: TextStyle(
                    fontSize: 13,
                    color: Utils.kPrimaryColor,
                    fontFamily: Utils.family),
              )
            ],
          ),
          Spacer(),
          Container(
            height: 30,
            width: 30,
            child: Center(
              child:
                  Icon(Icons.people_alt_rounded, color: Colors.white, size: 17),
            ),
            decoration: BoxDecoration(
                color: Utils.kDarkPrimaryColor, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }

//creating the gridview
  Widget buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 1, mainAxisSpacing: 1, maxCrossAxisExtent: 300),
      itemCount: this.services.length,
      itemBuilder: (context, index) {
        var service = this.services[index];
        return GridCard(
          function: () {
            Utils.navigation(
                context: context,
                destination: ViewCustomers(
                  selectedService: service.serviceName,
                ));
          },
          service: service,
        );
      },
    );
  }

//main build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Utils.shopName),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: this.menuItems(),
          ),
        ),
        floatingActionButton: Utils.customFloatingButton(
            context: context,
            text: "Add New Customer",
            function: () {
              Utils.navigation(context: context, destination: AddNewCustomer());
            }),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 30),
          child: Column(
            children: [
              SizedBox(
                height: 7,
              ),
              this.header(),
              SizedBox(
                height: 7,
              ),
              Divider(),
              SizedBox(
                height: 4,
              ),
              this.buildGridView()
            ],
          ),
        ));
  }
}
