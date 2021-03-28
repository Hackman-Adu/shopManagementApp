import 'dart:async';

import 'package:beautyShop/controllers/customersController.dart';
import 'package:beautyShop/controllers/paymentController.dart';
import 'package:beautyShop/controllers/serviceController.dart';
import 'package:beautyShop/models/customers.dart';
import 'package:beautyShop/models/payments.dart';
import 'package:beautyShop/pages/newCustomer.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:beautyShop/widgets/borderTextField.dart';
import 'package:beautyShop/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewPayment extends StatefulWidget {
  final String route;
  final Customers customer;
  final Payments selectedpayment;
  AddNewPayment({@required this.route, this.selectedpayment, this.customer});
  @override
  State<StatefulWidget> createState() {
    return AddNewPaymentState(
        route: this.route,
        selectedpayment: this.selectedpayment,
        customer: this.customer);
  }
}

class AddNewPaymentState extends State<AddNewPayment> {
  final String route;
  final Customers customer;
  final Payments selectedpayment;
  AddNewPaymentState(
      {@required this.route, this.selectedpayment, this.customer});
  var formKey = GlobalKey<FormState>();
  Payments payment = new Payments();
  TextEditingController customerID;
  TextEditingController customerFullName;
  TextEditingController service;
  TextEditingController amount;

  Widget spacer({double height = 27}) {
    return SizedBox(
      height: height,
    );
  }

  void addingNewPayment() {
    this.payment.date = new DateTime.now().toString();
    Provider.of<PaymentController>(context, listen: false)
        .addNewPayment(payment);
    Utils.showpinnerDialog(context: context, text: 'Adding New Payment...');
    Timer(Duration(milliseconds: 500), () {
      this.formKey.currentState.reset();
      Navigator.of(context).pop();
      Utils.simpleAlert(
          context: context,
          content: "Payment successfully Added",
          title: "New Payment");
    });
  }

  void updatingPayment() {
    this.selectedpayment.amount = amount.text;
    this.selectedpayment.customerID = customerID.text;
    this.selectedpayment.service = service.text;
    this.selectedpayment.amount = this.amount.text;
    Provider.of<PaymentController>(context, listen: false)
        .updatePayment(this.selectedpayment);
    Utils.showpinnerDialog(context: context, text: 'Updating Payment...');
    Timer(Duration(milliseconds: 500), () {
      Navigator.of(context).pop();
      Utils.simpleAlert(
          context: context,
          content: "Payment successfully Updated",
          title: "Payment Updated");
    });
  }

  void showServices() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ListView(
              shrinkWrap: true,
              children: [
                ...Provider.of<ServiceController>(context)
                    .services
                    .map((service) {
                  return ListTile(
                      trailing: service.serviceName == this.service.text
                          ? Utils.checkBox()
                          : Text(''),
                      onTap: () {
                        Navigator.of(context).pop();
                        this.service.text = service.serviceName;
                      },
                      title: Text(service.serviceName));
                }).toList()
              ],
            ),
          );
        });
  }

  void showCustomers() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ListView(
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: true,
              children: [
                ...Provider.of<CustomersControllers>(context)
                    .customers
                    .map((customer) {
                  return ListTile(
                      trailing: customer.customerID == this.customerID.text
                          ? Utils.checkBox()
                          : Text(''),
                      leading: customer.image != ''
                          ? CircleAvatar(
                              backgroundImage: AssetImage(customer.image),
                            )
                          : CircleAvatar(
                              child: Center(
                                child:
                                    Text(Utils.getInitials(customer.fullName)),
                              ),
                            ),
                      onTap: () {
                        Navigator.of(context).pop();
                        this.customerID.text = customer.customerID;
                        this.customerFullName.text = customer.fullName;
                      },
                      title: Text(customer.fullName));
                }).toList()
              ],
            ),
          );
        });
  }

  List<Widget> generateInputFields() {
    return [
      AllBorderField(
        hint: "Select Customer",
        label: "Customer ID",
        controller: this.customerID,
        validator: (value) {
          if (value.trim() == '') {
            return "Select a customer";
          } else {
            return null;
          }
        },
        suffixIcon: Icon(Icons.arrow_drop_down),
        onTap: () {
          this.showCustomers();
        },
        isReadOnly: true,
        isEnabled:
            this.route == 'profile' || this.route == 'update' ? false : true,
        onSaved: (value) {
          this.payment.customerID = value;
        },
      ),
      this.spacer(),
      AllBorderField(
        controller: this.customerFullName,
        hint: "Customer Fullname",
        label: "Customer Fullname",
        isEnabled: false,
        isReadOnly: true,
        onTap: null,
      ),
      this.spacer(),
      AllBorderField(
        hint: "Select Service",
        controller: this.service,
        label: "Service",
        suffixIcon: Icon(Icons.arrow_drop_down),
        onTap: () {
          this.showServices();
        },
        validator: (value) {
          if (value.trim() == '') {
            return "Select a service";
          } else {
            return null;
          }
        },
        isReadOnly: true,
        onSaved: (value) {
          this.payment.service = value;
        },
      ),
      this.spacer(),
      AllBorderField(
        controller: this.amount,
        action: TextInputAction.done,
        hint: "Amount ${Utils.ghanaCedi()}",
        type: TextInputType.number,
        label: "Amount ${Utils.ghanaCedi()}",
        onSaved: (value) {
          this.payment.amount = value;
        },
        validator: (value) {
          if (value.trim() == '') {
            return "Amount is required";
          } else {
            return null;
          }
        },
      ),
      this.spacer(),
      CustomButton(
        text: this.route != 'update' ? "Save" : 'Update Payment',
        onClicked: () {
          if (this.route != "update") {
            if (this.formKey.currentState.validate()) {
              this.formKey.currentState.save();
              this.addingNewPayment();
            }
          } else {
            if (this.formKey.currentState.validate()) {
              this.updatingPayment();
            }
          }
        },
      ),
      this.spacer(),
    ];
  }

  Widget header() {
    return Row(
      children: [
        SizedBox(width: 8.5),
        Icon(Icons.payment_rounded, size: 45, color: Utils.kPrimaryColor),
        SizedBox(width: 7),
        Text(
          "Add New Payment",
          style: TextStyle(fontSize: 17, color: Utils.kPrimaryColor),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    this.initTextfieldsValuesForUpdate();
    this.initValues();
  }

  initTextfieldsValuesForUpdate() {
    if (this.route == "update") {
      this.customerID =
          new TextEditingController(text: this.selectedpayment.customerID);
      this.service =
          new TextEditingController(text: this.selectedpayment.service);
      this.amount =
          new TextEditingController(text: this.selectedpayment.amount);
      this.customerFullName =
          new TextEditingController(text: this.customer.fullName);
    } else if (this.route == "profile") {
      this.customerID =
          new TextEditingController(text: this.customer.customerID);
      this.service = new TextEditingController();
      this.amount = new TextEditingController();
      this.customerFullName =
          new TextEditingController(text: this.customer.fullName);
    } else {
      this.customerID = new TextEditingController();
      this.customerFullName = new TextEditingController();
      this.service = new TextEditingController();
      this.amount = new TextEditingController();
    }
  }

  initValues() {
    if (this.route == 'profile') {
      this.customerID.text = this.customer.customerID;
      this.customerFullName.text = this.customer.fullName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(this.route != "update" ? "New Payment" : "Update Payment"),
          actions: [
            IconButton(
                splashRadius: 20,
                icon: Icon(Icons.person_add_alt_1_rounded),
                onPressed: this.route != "update"
                    ? () {
                        Utils.navigation(
                            context: context, destination: AddNewCustomer());
                      }
                    : null)
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              this.header(),
              SizedBox(
                height: 25,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Form(
                    key: this.formKey,
                    child: Column(
                      children: [...this.generateInputFields()],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
