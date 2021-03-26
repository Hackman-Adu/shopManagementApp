import 'package:beautyShop/controllers/customersController.dart';
import 'package:beautyShop/pages/managePayment.dart';
import 'package:beautyShop/pages/manageServices.dart';
import 'package:beautyShop/pages/newCustomer.dart';
import 'package:beautyShop/pages/settings.dart';
import 'package:beautyShop/pages/reports.dart';
import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:beautyShop/pages/login.dart';
import 'package:provider/provider.dart';
import '../models/customers.dart';
import 'package:beautyShop/pages/customerProfile.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
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

//build customersList
  Widget customersList(List<Customers> customers) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        ...customers.map((customer) {
          return ListTile(
            onTap: () {
              Utils.navigation(
                  context: context,
                  destination: CustomerProfile(
                    customer: customer,
                  ));
            },
            title: Text(customer.fullName),
            subtitle: Text(customer.address),
            leading: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(customer.image)),
                    shape: BoxShape.circle),
                width: 50,
                height: 50),
          );
        }).toList()
      ],
    );
  }

//header widget
  Widget header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "My Customers",
            style: TextStyle(fontSize: 17, color: Utils.kDarkPrimaryColor),
          ),
          Spacer(),
          Consumer<CustomersControllers>(builder: (context, controller, child) {
            return Text(
              "(${controller.customers.length})",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            );
          })
        ],
      ),
    );
  }

//main build method
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<CustomersControllers>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(Utils.shopName),
          actions: [
            IconButton(
                splashRadius: 20, icon: Icon(Icons.search), onPressed: () {})
          ],
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
        body: controller.isLoading == false
            ? SingleChildScrollView(
                padding: EdgeInsets.only(top: 15, bottom: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: this.header(),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Divider(),
                    SizedBox(
                      height: 4,
                    ),
                    this.customersList(controller.customers)
                  ],
                ),
              )
            : Center(
                child: Utils.spinner(),
              ));
  }
}
