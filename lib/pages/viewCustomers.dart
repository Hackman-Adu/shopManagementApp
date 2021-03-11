import 'package:beautyShop/models/customers.dart';
import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';
import 'dart:async';

class ViewCustomers extends StatefulWidget {
  final String selectedService;
  ViewCustomers({@required this.selectedService});
  @override
  State<StatefulWidget> createState() {
    return ViewCustomerState(selectedService: this.selectedService);
  }
}

class ViewCustomerState extends State<ViewCustomers> {
  final String selectedService;
  List<Customers> customers = [];
  List<Customers> allCustomers = [];
  int length = 0;
  bool isLoading = true;
  ViewCustomerState({@required this.selectedService});

  Widget header() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Text("Available Customers",
                        style: TextStyle(
                            fontSize: 18,
                            color: Utils.kDarkPrimaryColor,
                            fontFamily: Utils.family))),
                SizedBox(
                  width: 7,
                ),
                Text(
                  "(${this.length})",
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 13,
            ),
            Card(
              elevation: 25,
              shadowColor: Colors.black.withOpacity(0.25),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 5),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          this.searching(value);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search customer"),
                      ),
                    ),
                    IconButton(
                      splashRadius: 20,
                      onPressed: () {},
                      icon: Icon(Icons.cancel),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget avatarImage(String image) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
          shape: BoxShape.circle),
    );
  }

  Widget listView() {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        ...this.customers.map((customer) {
          return Column(
            children: [
              ListTile(
                  onTap: () {},
                  title: Text(
                    customer.fullName,
                    style: TextStyle(
                        fontSize: 17, color: Colors.black.withOpacity(0.85)),
                  ),
                  trailing: Icon(Icons.chevron_right),
                  leading: avatarImage(customer.image),
                  subtitle: Text(
                    customer.address,
                    style: TextStyle(fontSize: 13, fontFamily: Utils.family),
                  )),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Divider(),
              )
            ],
          );
        }).toList()
      ],
    );
  }

  void searching(String value) {
    if (value.trim() != '') {
      setState(() {
        this.customers = this.allCustomers.where((customer) {
          return customer.fullName
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              customer.address.toLowerCase().contains(value.toLowerCase());
        }).toList();
      });
    } else {
      setState(() {
        this.customers = this.allCustomers;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        this.isLoading = false;
      });
    });
    this.customers = Customers().getCustomers().where((customer) {
      return customer.serviceType.toLowerCase() ==
          this.selectedService.toLowerCase();
    }).toList();
    this.allCustomers = this.customers;
    this.length = customers.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedService),
        ),
        body: this.isLoading == false
            ? length != 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [header(), listView()],
                    ),
                  )
                : Center(
                    child: Text(
                      "No customers available\nfor ${this.selectedService}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  )
            : Center(
                child: Utils.spinner(),
              ));
  }
}
