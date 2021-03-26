import 'package:beautyShop/providers.dart';
import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:beautyShop/pages/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: Providers.providers(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Divas Beauty Shop',
        theme: ThemeData(
          appBarTheme: AppBarTheme(brightness: Brightness.dark),
          primaryColor: Utils.kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen());
  }
}
