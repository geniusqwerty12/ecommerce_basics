import 'package:ecommerce_basics_1/services/AuthService.dart';
import 'package:ecommerce_basics_1/services/DatabaseService.dart';
import 'package:flutter/material.dart';

// Dashboard Widget
class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Create the class AuthService
  AuthService _authService = AuthService();

  // User id variable
  String userId;

  @override
  Widget build(BuildContext context) {

    userId = ModalRoute.of(context).settings.arguments;
    print(userId);

    return Scaffold(
      appBar: AppBar (
        title: Text("Dashboard"),
        actions: [
          ElevatedButton(
            child: Text("Log out"),
            onPressed: () async {
              // Trigger the logoutUser
              var logOutObj = await _authService.logoutUser();
              print(logOutObj);
              Navigator.pushReplacementNamed(context, 'auth');
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            displayUserData(),
            SizedBox(height: 20),
            displayProducts(),

            // Logout button
            // ElevatedButton(
            //   child: Text("Log out"),
            //   onPressed: () async {
            //     // Trigger the logoutUser
            //     var logOutObj = await _authService.logoutUser();
            //     print(logOutObj);
            //     Navigator.pushReplacementNamed(context, 'auth');
            //   },
            // ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "cart");
              }, 
              icon: Icon(Icons.shopping_bag_rounded),
              label: Text("My Cart"))
          ],
        ),
      ),
    );
  }

  // function to fetch the user information and display on a text widget
  Widget displayUserData(){
    // Add a FutureBuilder to handle the fetching of users which is a
    // Future function
    return new FutureBuilder(
      future: DatabaseService(uid: userId).fetchUserData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data != null && snapshot.data.exists) {
            return Text(
              "Welcome ${snapshot.data['firstName']} ${snapshot.data['lastName']}",
              style: TextStyle(fontSize: 18),
            );
          } else {
            return Text("No user information");
          }
        } else {
          return new CircularProgressIndicator();
        }
      }
    );
  }

  // Function to fetch the products/items and display it in a list
  Widget displayProducts() {
    return FutureBuilder(
      future: DatabaseService().fetchProducts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Check if data is present, process is finished
        if(snapshot.hasData) {
          print(snapshot.data);
          // List of items, this is where we will store the them
          List items = [];
          // insert all of the documents in the items list
          snapshot.data.documents.map((document) {
            items.add(document);
          }).toList();

          return Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                // Display the product info
                return ListTile(
                  // On press equivalent
                  onTap: () {
                    // Get the user id and item variable to be passed on the item info
                    // screen
                    Map<String, dynamic> args = new Map();
                    args['userId'] = userId;
                    args['item'] = items[index];

                    Navigator.pushNamed(context, 'itemInfo', arguments: args);
                  },
                  // leading, title & subtitle, trailing
                  leading: Image.network(items[index]['image'], height: 100, width: 100),
                  title: Text(items[index]['itemName']),
                  subtitle: Text("${items[index]['itemPrice']} ${items[index]['currency']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      print('Add to cart!');
                      await DatabaseService(uid: userId).addToCart(items[index].reference.documentID);
                      
                      // Show notification
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Item has been added to cart!"))
                      );
                    },
                  ),
                );
              }
            ),
          );
        } else {
          return new CircularProgressIndicator();
        }
      }
    );
  }
}