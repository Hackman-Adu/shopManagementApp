import 'package:flutter/material.dart';
import 'package:beautyShop/models/services.dart';
import 'dart:async';
import 'package:beautyShop/utils/utils.dart';
import "package:beautyShop/widgets/textField.dart";
import 'package:beautyShop/widgets/customButton.dart';
import 'dart:io';

class ManageServices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageServiceState();
  }
}

class ManageServiceState extends State<ManageServices> {
  List<MyServices> services = MyServices().getServices();
  MyServices addedService;
  var formKey = GlobalKey<FormState>();
  bool isLoading = true;
  var key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    this.addedService = new MyServices();
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget header() {
    return Row(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("My Services",
                style: TextStyle(
                    fontSize: 18,
                    color: Utils.kDarkPrimaryColor,
                    fontFamily: Utils.family))),
        SizedBox(
          width: 7,
        ),
        Text(
          "(${this.services.length})",
          style: TextStyle(fontSize: 17, color: Colors.grey),
        )
      ],
    );
  }

  Future<MyServices> addNewService() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17)),
              title: Text("Add New Service"),
              content: Form(
                key: this.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomFormField(
                      onSaved: (value) {
                        this.addedService.serviceName = value;
                      },
                      placeholder: "Enter service name",
                      type: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    CustomFormField(
                      onSaved: (value) {
                        this.addedService.description = value;
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
                        Navigator.of(context).pop(this.addedService);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this.key,
      appBar: AppBar(
        title: Text("Manage Services"),
      ),
      floatingActionButton: Utils.customFloatingButton(
          context: context,
          text: "Add New Service",
          function: () async {
            MyServices newService = await this.addNewService();
            if (newService.serviceName.trim() != '' ||
                newService.description.trim() != '') {
              Platform.isAndroid
                  ? Utils.androidLoadingSpinner(context, text: 'Please wait...')
                  : Utils.iOSLoadingSpinner(context, text: "Please wait...");
              Timer(Duration(milliseconds: 1000), () {
                Navigator.of(context).pop();
                setState(() {
                  this.services.insert(0, newService);
                });
                Utils.showSnackBar(key, "Service successfully added");
              });
            }
          }),
      body: isLoading == false
          ? ListView(
              children: [
                SizedBox(
                  height: 25,
                ),
                header(),
                SizedBox(
                  height: 21,
                ),
                ...this.services.map((service) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        title: Text(
                          service.serviceName,
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black.withOpacity(0.85)),
                        ),
                        subtitle: Text(service.description ?? ''),
                        trailing: Icon(Icons.chevron_right),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Divider(),
                      )
                    ],
                  );
                }).toList()
              ],
            )
          : Center(child: Utils.spinner()),
    );
  }
}
