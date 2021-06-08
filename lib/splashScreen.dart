import 'package:ecommerce_basics_1/services/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Create the authservice to call the isLoggedIn
  AuthService _authService = AuthService();

  @override
  void initState() { 
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUser();
    });
  }

  checkUser() async {
    FirebaseUser user = await _authService.isLoggedIn();
    if(user != null) {
      // navigate to the dashboard and pass the user id variable
      Navigator.pushReplacementNamed(context, 'dash', arguments: user.uid);
    } else {
      Navigator.pushReplacementNamed(context, 'auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loading..."),
      ),
    );
  }
}