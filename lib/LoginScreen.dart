import 'package:ecommerce_basics_1/services/AuthService.dart';
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

  // Instance of the service
  AuthService _authService = AuthService();

  // Variables to keep track of the text fields
  String email;
  String password;

  // variable to determine if the login function is ongoing
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Add a basic design here
    return Scaffold(
      // add app bar with title
      appBar: AppBar(title: Text("LOGIN")),
      // add body that will house the button

      // Wrapped the Column widget with a Container to add padding
      // body: _isLoading 
      // ? Center(
      //   child:  CircularProgressIndicator(),
      // ) 
      // : Container(
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
                    enabled: !_isLoading,
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
                    onChanged: (value) {
                      setState(() {
                         email = value;                     
                      });
                    },
                  ),
                  // Added a space in between the text forms
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    enabled: !_isLoading,
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
                      // Password should have atleast 1
                      // Uppercase letter, lowercase letter, digit, special character
                      RegExp hasUpper = RegExp(r'[A-Z]');
                      RegExp hasLower = RegExp(r'[a-z]');
                      RegExp hasDigit = RegExp(r'\d');
                      RegExp hasPunct = RegExp(r'[_!@#\$&*~-]');

                      if (!hasUpper.hasMatch(value))
                        return 'Password must have at least one uppercase character';
                      if (!hasLower.hasMatch(value))
                        return 'Password must have at least one lowercase character';
                      if (!hasDigit.hasMatch(value))
                        return 'Password must have at least one number';
                      if (!hasPunct.hasMatch(value))
                        return 'Passwordd need at least one special character like !@#\$&*~-';

                      return null;
                    },
                    obscureText: true,
                     onChanged: (value) {
                      setState(() {
                         password = value;                     
                      });
                    },
                  ),
                ],
                )
              ),
              SizedBox(height: 20),

              // Show the loading widget here instead
              _isLoading ? Center(child: CircularProgressIndicator()) : Container(),
              
              // Changed the textbutton to elevatedbutton to add the design
              // implements an icon button, icon and label are required
              ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text("LOGIN"),
                onPressed: _isLoading ? null : () {
                  // Trigger the LOGIN
                  if(formkey.currentState.validate()) {
                    print("You can login");
                    setState(() {
                      _isLoading = true;          
                    });

                    var userObj = _authService.loginUser(email, password);
                    if(userObj != null) {
                      Navigator.pushReplacementNamed(context, 'dash');
                    }
                  } else {
                    print("You cannot login");
                    setState(() {
                      _isLoading = false;          
                    });
                  }
                },
              ),

              ElevatedButton(
                child: Text("Sign up here"),
                onPressed: _isLoading ? null : () {
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