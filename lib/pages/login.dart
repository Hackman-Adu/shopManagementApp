import 'package:beautyShop/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:beautyShop/utils/utils.dart';
import 'package:beautyShop/widgets/textField.dart';
import 'package:beautyShop/widgets/customButton.dart';
import 'dart:async';
import 'package:beautyShop/pages/home.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> with SingleTickerProviderStateMixin {
  var formKey = GlobalKey<FormState>();
  var key = GlobalKey<ScaffoldState>();
  bool togglePasswordVisibility = true;
  AnimationController animationController;
  Animation animation;
  CurvedAnimation curve;
  String username = "";
  String password = "";

  //handling non-backend login
  void login() {
    this.formKey.currentState.save();
    if (this.username.trim() == '' || this.password.trim() == '') {
      Utils.simpleAlert(
          context: context,
          title: "Empty",
          content: "Password and username are required");
      return;
    }
    Utils.showpinnerDialog(context: context, text: "Authenticating...");
    Timer(Duration(milliseconds: 1000), () {
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashBoard()));
    });
  }

  Widget form() {
    return Form(
      key: this.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomFormField(
            onSaved: (value) {
              this.username = value;
            },
            leadingIcon: Icon(
              Icons.person,
              color: Utils.kPrimaryColor,
            ),
            action: TextInputAction.next,
            placeholder: "Enter your username",
            hasTrailingIcon: false,
          ),
          SizedBox(
            height: 10,
          ),
          CustomFormField(
            onSaved: (value) {
              this.password = value;
            },
            leadingIcon: Icon(
              Icons.lock,
              color: Utils.kPrimaryColor,
            ),
            isPassword: this.togglePasswordVisibility,
            action: TextInputAction.done,
            placeholder: "Enter your password",
            hasTrailingIcon: true,
            trailingIcon: IconButton(
              onPressed: () {
                setState(() {
                  this.togglePasswordVisibility =
                      !this.togglePasswordVisibility;
                });
              },
              splashRadius: 20,
              icon: Icon(
                togglePasswordVisibility
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Utils.kPrimaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton(
            onClicked: () {
              this.login();
            },
            text: "Login",
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Center(
        child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                "Forgot Password",
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            )),
      ),
      width: double.infinity,
    );
  }

  @override
  void initState() {
    super.initState();
    this.animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 250));
    this.curve = new CurvedAnimation(
        curve: Curves.bounceIn, parent: this.animationController);
    this.animation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
    this.animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    this.animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            key: this.key,
            backgroundColor: Utils.kPrimaryColor,
            body: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.25),
                        child: Center(
                          child: Text(
                            Utils.shopName,
                            style: TextStyle(
                                fontSize: 45,
                                fontFamily: "Redressed-Regular",
                                color: Colors.white),
                          ),
                        ),
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ScaleTransition(
                          scale: this.animation,
                          child: Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            shadowColor: Colors.black.withOpacity(0.25),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: this.form()),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      this.forgotPassword(),
                      Utils.bottomText()
                    ],
                  )),
            )));
  }
}
