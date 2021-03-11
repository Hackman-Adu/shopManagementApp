import 'dart:async';

import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(milliseconds: 300), () {
//navigate to login screen
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: double.infinity,
        child: Center(
          child: Utils.spinner(),
        ),
      ),
    );
  }
}
