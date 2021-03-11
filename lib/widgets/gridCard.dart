import 'package:beautyShop/models/services.dart';
import "package:flutter/material.dart";
import 'package:beautyShop/utils/utils.dart';

class GridCard extends StatelessWidget {
  final MyServices service;
  final Function function;
  GridCard({@required this.service, @required this.function});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 25,
      shadowColor: Colors.black.withOpacity(0.25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(service.serviceIcon),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 1, color: Utils.kPrimaryColor)),
                onPressed: function,
                height: 40,
                minWidth: double.infinity,
                textColor: Utils.kPrimaryColor,
                child: Center(
                  child: Text(
                    service.serviceName.toUpperCase(),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7,
            )
          ],
        ),
      ),
    );
  }
}
