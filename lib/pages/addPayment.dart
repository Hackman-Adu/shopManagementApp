import 'package:beautyShop/controllers/customersController.dart';
import 'package:beautyShop/controllers/serviceController.dart';
import 'package:beautyShop/models/payments.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:beautyShop/widgets/borderTextField.dart';
import 'package:beautyShop/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewPayment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNewPaymentState();
  }
}

class AddNewPaymentState extends State<AddNewPayment> {
  var formKey = GlobalKey<FormState>();
  Payments payment = new Payments();
  TextEditingController customerID = new TextEditingController();
  TextEditingController customerFullName = new TextEditingController();
  TextEditingController service = new TextEditingController();

  Widget spacer({double height = 27}) {
    return SizedBox(
      height: height,
    );
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
              shrinkWrap: true,
              children: [
                ...Provider.of<CustomersControllers>(context)
                    .customers
                    .map((customer) {
                  return ListTile(
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
        text: "Save",
        onClicked: () {
          if (this.formKey.currentState.validate()) {
            this.formKey.currentState.save();
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
        Icon(Icons.payment_rounded,
            size: 45, color: Utils.kPrimaryColor.withOpacity(0.75)),
        SizedBox(width: 7),
        Text(
          "Add New Payment",
          style: TextStyle(
              fontSize: 17, color: Utils.kPrimaryColor.withOpacity(0.75)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Payment"),
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
