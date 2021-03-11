import 'package:beautyShop/pages/managePayment.dart';
import 'package:beautyShop/pages/manageServices.dart';
import 'package:beautyShop/pages/newCustomer.dart';
import 'package:beautyShop/pages/settings.dart';
import 'package:beautyShop/pages/summary.dart';
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
  List<MyServices> services = MyServices().getServices();
  //generating the menu items
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
      )
      //items
      ,
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
          'Summary',
          style: Utils.menuTextStyle(),
        ),
        leading: Icon(Icons.supervisor_account_rounded),
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
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        title: Text(
          'Logout',
          style: Utils.menuTextStyle(),
        ),
        leading: Icon(Icons.login_outlined),
      ),
    ];
  }

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
            children: [this.buildGridView()],
          ),
        ));
  }
}
