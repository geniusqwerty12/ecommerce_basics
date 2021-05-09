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
                    hintText: "Sample City",
                    labelText: "City",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  validator: (value) {
                    if(value.isEmpty) {
                      return "City is required";
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