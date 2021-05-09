import 'package:ecommerce_basics_1/authenticationScreen.dart';
import 'package:flutter/material.dart';

// TODOs
// Create an application that has two screens, Login and Sign up - done
// Toggle in between the Screens - done
// Add form fields - done
// Add form field validation - done
// Add a simple design - done
// Integrate Firebase to enable the Login/Sign up functionalities

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationScreen(),
    );
  }
}
