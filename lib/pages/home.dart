import 'package:beautyShop/pages/managePayment.dart';
import 'package:beautyShop/pages/manageServices.dart';
import 'package:beautyShop/pages/settings.dart';
import 'package:beautyShop/pages/summary.dart';
import 'package:beautyShop/pages/viewCustomers.dart';
import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:beautyShop/models/services.dart';
import 'package:beautyShop/widgets/gridCard.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  bool isGridView = true;
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
          'Management Payments',
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
          //logout
        },
        title: Text(
          'Logout',
          style: Utils.menuTextStyle(),
        ),
        leading: Icon(Icons.login_outlined),
      ),
    ];
  }

  Widget headerCard() {
    return Card(
      shadowColor: Colors.black.withOpacity(0.25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
        child: Row(
          children: [
            Icon(
              Icons.people_alt_rounded,
              size: 20,
            ),
            SizedBox(
              width: 7,
            ),
            Text("Segmented Customers",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Utils.kPrimaryColor.withOpacity(0.85))),
            Spacer(),
            IconButton(
              splashRadius: 21,
              onPressed: () {
                setState(() {
                  this.isGridView = !this.isGridView;
                });
              },
              icon: Icon(this.isGridView ? Icons.dashboard : Icons.view_list),
            )
          ],
        ),
      ),
    );
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
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
          child: Column(
            children: [this.buildGridView()],
          ),
        ));
  }
}
