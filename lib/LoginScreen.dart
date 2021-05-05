import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.toggleScreen}) : super(key: key);

  final Function toggleScreen;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // Add a basic design here
    return Scaffold(
      // add app bar with title
      appBar: AppBar(title: Text("LOGIN")),
      // add body that will house the button
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: "Input email here"
            ),
          ),

          TextFormField(
            decoration: InputDecoration(
              hintText: "Input password here"
            ),
            obscureText: true,
          ),

          TextButton(
            child: Text("LOGIN"),
            onPressed: () {
              // Trigger the LOGIN
            },
          ),

          TextButton(
            child: Text("Sign up here"),
            onPressed: () {
              widget.toggleScreen();
            },
          ),
        ],
      )
    );
  }
}