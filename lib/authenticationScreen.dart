import 'package:ecommerce_basics_1/LoginScreen.dart';
import 'package:ecommerce_basics_1/RegisterScreen.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  AuthenticationScreen({Key key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  
  // create a variable that will determine what screen the app will show
  bool showLogin = true;
  
  // create a function to toggle the screens
  void toggleScreens() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return LoginScreen();
    // check what screen to display
    // if(showLogin) {
    //   return LoginScreen();
    // } else {
    //   return RegisterScreen();
    // }

    return showLogin ? LoginScreen(toggleScreen: toggleScreens,) : RegisterScreen(toggleScreen: toggleScreens,);
  }
}