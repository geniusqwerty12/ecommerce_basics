import 'package:ecommerce_basics_1/services/DatabaseService.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String userId;
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    // get the user id from the argumets
    userId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              // function to return the widget that will render the cart list
              displayCartItems(),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayCartItems() {
    // Return a stream builder to manage the incoming events
    return StreamBuilder(
      stream: DatabaseService(uid: userId).fetchCart(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          // print(snapshot.data);

          List carts = [];
          snapshot.data.documents.map( (cart) {
            // print(cart['itemId']);
            carts.add(cart);
          }).toList();

          // Display the cart items on a list
          return Expanded(
            child: ListView.builder(
              itemCount: carts.length,
              itemBuilder: (context, index) {
                // Fetch the item information
                return FutureBuilder(
                  future: _databaseService.fetchItemInfo(carts[index]['itemId']),
                  builder: (BuildContext cxt, AsyncSnapshot snapshot) {
                    if(snapshot.hasData) {
                      
                      return ListTile(
                      // On press equivalent
                          onTap: () {
                          // Get the user id and item variable to be passed on the item info
                          // screen
                          Map<String, dynamic> args = new Map();
                          args['userId'] = userId;
                          args['item'] = snapshot.data;

                          Navigator.pushNamed(context, 'itemInfo', arguments: args);
                        },
                      // leading, title & subtitle, trailing
                      leading: Image.network(snapshot.data['image'], height: 100, width: 100),
                      title: Text(snapshot.data['itemName']),
                      subtitle: Text("${snapshot.data['itemPrice']} ${snapshot.data['currency']}"),
                      
                      trailing: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () async {
                          print('Remove to cart!');
                          await _databaseService.removeCart(carts[index].reference.documentID);
                          // Show notification
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Item has been removed from your cart!"))
                          );
                        },
                      ),
                    );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                );
              }
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}