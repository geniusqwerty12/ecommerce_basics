import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key, this.toggleScreen}) : super(key: key);

  final Function toggleScreen;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    // Add a basic design here
    return Scaffold(
      // add app bar with title
      appBar: AppBar(title: Text("REGISTER")),
      // add body that will house the button
       body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: "First name"
            ),
          ),

          TextFormField(
            decoration: InputDecoration(
              hintText: "Last name"
            ),
          ),
          
          TextFormField(
            decoration: InputDecoration(
              hintText: "City"
            ),
          ),

          TextFormField(
            decoration: InputDecoration(
              hintText: "Email address"
            ),
          ),

          TextFormField(
            decoration: InputDecoration(
              hintText: "Password"
            ),
            obscureText: true,
          ),

          TextButton(
            child: Text("REGISTER"),
            onPressed: () {
              // TODO trigger the registration
            },
          ),

          TextButton(
            child: Text("Login here"),
            onPressed: () {
              widget.toggleScreen();
            },
          ),
        ],
      )
    );
  }
}