import 'package:beautyShop/controllers/customersController.dart';
import 'package:beautyShop/pages/newCustomer.dart';
import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';
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
//build customersList
  Widget customersList(List<Customers> customers) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        ...customers.map((customer) {
          return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                onTap: () {
                  Utils.navigation(
                      context: context,
                      destination: CustomerProfile(
                        customer: customer,
                      ));
                },
                title: Text(
                  customer.fullName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(customer.address),
                leading: customer.image.trim() != ''
                    ? Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(customer.image)),
                            shape: BoxShape.circle),
                        width: 50,
                        height: 50)
                    : Container(
                        child: Center(
                          child: Text(
                            Utils.getInitials(customer.fullName),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Utils.kPrimaryColor, shape: BoxShape.circle),
                        width: 50,
                        height: 50),
              ));
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
          title: Text('Customers'),
          actions: [
            IconButton(
                splashRadius: 20, icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        floatingActionButton: Utils.customFloatingButton(
            context: context,
            text: "Add New Customer",
            function: () {
              Utils.navigation(context: context, destination: AddNewCustomer());
            }),
        body: controller.isLoading == false
            ? controller.customers.length > 0
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Customers Available",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Utils.kPrimaryColor),
                        ),
                        Text(
                          "Start adding new customers",
                          style: TextStyle(
                              fontSize: 14,
                              color: Utils.kPrimaryColor.withOpacity(0.5)),
                        )
                      ],
                    ),
                  )
            : Center(
                child: Utils.spinner(),
              ));
  }
}
