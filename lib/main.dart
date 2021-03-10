import 'package:beautyShop/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Divas Beauty Shop',
        theme: ThemeData(
          primaryColor: Utils.kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home());
  }
}
