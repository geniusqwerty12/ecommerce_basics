import 'package:ecommerce_basics_1/services/AuthService.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key, this.toggleScreen}) : super(key: key);

  final Function toggleScreen;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Global key
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // Variable to keep track of the input field values
  String _email;
  String _password;
  bool _didAgree = false;
  
  // Auth Service class
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // Add a basic design here
    return Scaffold(
      // add app bar with title
      appBar: AppBar(title: Text("REGISTER")),
      // add body that will house the button
       body: Container(
        //  This time we'll add the padding to all sides since we'll not align the widgets to the center
         padding: EdgeInsets.all(20),
         child: ListView(
          children: [
            //  Add the Form
            Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                  decoration: InputDecoration(
                    hintText: "John",
                    labelText: "First name",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  validator: (value) {
                    if(value.isEmpty) {
                      return "First name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Doe",
                    labelText: "Last name",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  validator: (value) {
                    if(value.isEmpty) {
                      return "Last name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
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
                  onChanged: (value){
                    setState(() {
                        _email = value;                  
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "*******",
                    labelText: "Password",
                    fillColor: Colors.white,
                    // properties related to border
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  obscureText: true,
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
                    // keep track of the textfield's value when the user
                    // types
                    onChanged: (value) {
                      setState(() {
                         _password = value;                     
                      });
                    },
                  // Confirm password
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "*******",
                      labelText: "Confirm Password",
                      fillColor: Colors.white,
                      // properties related to border
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                    obscureText: true,
                    validator: (value) {
                      if(value != _password) {
                        return "Password should match!";
                      }
                     return null;
                    },
                    // Confirm password
                  ),

                  // Checkbox
                  FormField(
                    initialValue: _didAgree,
                    builder: (FormFieldState<bool> state){
                      return Column(
                      // Checkbox and text that says "I agree to the terms" they are arranged horizontally
                      // so we wrap them inside a row
                        children: [
                         Row(
                            children: [
                              Checkbox(
                                // the value of the form state is given here, instead of the bool variable we initialized above
                                value: state.value, 
                                // this function will trigger every time the user clicks the checkbox
                                onChanged: (val){
                                  _didAgree = val;
                                  state.didChange(val); // this function will also update this form's state value
                                }
                              ),
                              Text("I agree to the terms.")
                            ],
                          ),

                          // Check if there is an error, the user forgot to check the box
                          // this errorText is available because it is a form field
                          // just like the TextFormFields
                          state.errorText == null
                          ? Text("")
                          : Text(state.errorText, style: TextStyle(color: Colors.red))
                       ],
                      );
                    },
                    validator: (value) {
                      if(!value) {
                        return "You must agree before signing up";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.app_registration),
              label: Text("REGISTER"),
              onPressed: () {
                // TODO trigger the registration
                // Trigger the validation first before adding the new user
                if(formkey.currentState.validate()){
                  print("User can register!");

                  var userObj = _authService.registerUser(_email, _password);
                  if(userObj != null) {
                    Navigator.pushReplacementNamed(context, 'dash');
                  }
                } else {
                  print("User cannot register");
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Text("Login here"),
              onPressed: () {
                widget.toggleScreen();
              },
            ),
          ],
      ),
       )
    );
  }
}