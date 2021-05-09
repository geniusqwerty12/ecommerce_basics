import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.toggleScreen}) : super(key: key);

  final Function toggleScreen;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Variable to hold the state of the forms
  // whether it is validated or not
  // it can trigger the validation
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Add a basic design here
    return Scaffold(
      // add app bar with title
      appBar: AppBar(title: Text("LOGIN")),
      // add body that will house the button

      // Wrapped the Column widget with a Container to add padding
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Image(
                image: AssetImage("assets/images/shopping_logo.jpg"),
                width: 100,
                height: 100,
              ),

              // Widget to hold the text forms
              Form(
                key: formkey, // attach the Form widget to the GlobalKey
                child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      // improve the design of the text form field
                      hintText: "example@gmail.com",
                      labelText: "Email",
                      fillColor: Colors.white,
                      // properties related to border
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return "Email is required";
                      }
                      // example@gmail.com
                      if( !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) ){
                          return "This value is not a valid email address";
                        }
                      return null;
                    },
                  ),
                  // Added a space in between the text forms
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "*****",
                      labelText: "Password",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return "Password is required";
                      }
                      if(value.length < 6 ) {
                        return "Password should be more than 5 characters";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                ],
                )
              ),
              
              // Changed the textbutton to elevatedbutton to add the design
              // implements an icon button, icon and label are required
              ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text("LOGIN"),
                onPressed: () {
                  // Trigger the LOGIN
                  if(formkey.currentState.validate()) {
                    print("You can login");
                  } else {
                    print("You cannot login");
                  }
                },
              ),

              ElevatedButton(
                child: Text("Sign up here"),
                onPressed: () {
                  widget.toggleScreen();
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}