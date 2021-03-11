import 'package:flutter/material.dart';

class ManageServices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageServiceState();
  }
}

class ManageServiceState extends State<ManageServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Services"),
      ),
    );
  }
}
