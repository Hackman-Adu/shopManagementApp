import 'package:beautyShop/controllers/serviceController.dart';
import 'package:flutter/material.dart';
import 'package:beautyShop/models/services.dart';
import 'dart:async';
import 'package:beautyShop/utils/utils.dart';
import "package:beautyShop/widgets/textField.dart";
import 'package:beautyShop/widgets/customButton.dart';
import 'package:provider/provider.dart';

class ManageServices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageServiceState();
  }
}

class ManageServiceState extends State<ManageServices> {
  MyServices service = new MyServices();
  var formKey = GlobalKey<FormState>();
//header widget
  Widget header() {
    return Row(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("My Services",
                style: TextStyle(
                  fontSize: 18,
                  color: Utils.kDarkPrimaryColor,
                ))),
        SizedBox(
          width: 7,
        ),
        Consumer<ServiceController>(
          builder: (context, controller, child) {
            return Text(
              "(${controller.services.length})",
              style: TextStyle(fontSize: 17, color: Colors.grey),
            );
          },
        )
      ],
    );
  }

//displaying the add new service alert dialog
  Future<MyServices> addNewService() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              scrollable: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17)),
              title: Row(
                children: [
                  Text("Add New Service"),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(null);
                    },
                    splashRadius: 20,
                    icon: Icon(Icons.cancel),
                  )
                ],
              ),
              content: Form(
                key: this.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomFormField(
                      onSaved: (value) {
                        this.service.serviceName = value;
                      },
                      placeholder: "Enter service name",
                      type: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    CustomFormField(
                      onSaved: (value) {
                        this.service.description = value;
                      },
                      placeholder: "Service description",
                      type: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    CustomButton(
                      text: "Save",
                      onClicked: () {
                        this.formKey.currentState.save();
                        Navigator.of(context).pop(this.service);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void addingNewService() async {
    var controller = Provider.of<ServiceController>(context, listen: false);
    var value = await this.addNewService();
    if (value.serviceName.trim() != '' && value.description.trim() != '') {
      Utils.showpinnerDialog(context: context, text: "Adding service...");
      Timer(Duration(milliseconds: 500), () {
        Navigator.of(context).pop();
        controller.addNewService(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ServiceController>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Manage Services"),
        ),
        floatingActionButton: Utils.customFloatingButton(
            context: context,
            text: "Add New Service",
            function: () {
              this.addingNewService();
            }),
        body: controller.isLoading == false
            ? controller.services.length > 0
                ? ListView(
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 1.5),
                    children: [
                        this.header(),
                        SizedBox(height: 13),
                        Divider(),
                        ...controller.services.map((service) {
                          return Column(
                            children: [
                              ListTile(
                                  subtitle: Text(
                                    service.description,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Utils.kPrimaryColor
                                            .withOpacity(0.75)),
                                  ),
                                  title: Text(service.serviceName,
                                      style: TextStyle(
                                          fontSize: 17.5,
                                          color:
                                              Colors.black.withOpacity(0.65)))),
                              Padding(
                                  padding: EdgeInsets.only(left: 7),
                                  child: Divider()),
                            ],
                          );
                        }).toList()
                      ])
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Services Added",
                          style: TextStyle(
                              fontSize: 21,
                              color: Utils.kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("Start adding your services",
                            style: TextStyle(
                                fontSize: 14,
                                color: Utils.kPrimaryColor.withOpacity(0.65)))
                      ],
                    ),
                  )
            : Center(
                child: Utils.spinner(),
              ));
  }
}
