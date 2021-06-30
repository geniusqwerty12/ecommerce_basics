import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_basics_1/services/DatabaseService.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class ItemInfoScreen extends StatelessWidget {
  const ItemInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map pageParams = ModalRoute.of(context).settings.arguments;

    String userId = pageParams['userId'];
    DocumentSnapshot item = pageParams['item'];

    // Analytics class for calling the functions
    FirebaseAnalytics _analytics = FirebaseAnalytics();

    sendAnalytics() async {
      await _analytics.logEvent(
        name: "check_item",
        parameters: <String, dynamic> {
          'itemId' : item.id,
          'itemName' : item['itemName'],
          'userId' : userId,
        }
      );
    }

    sendAnalytics();

    return Scaffold(
      appBar: AppBar(
        // should display the item name
        title: Text(item["itemName"]),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Image
              Image.network(item["image"], width: 200, height: 200,),
              SizedBox(height: 20,),
              // Description
              Text(item["description"]),
              SizedBox(height: 20,),
              // Price
              Text("${item["itemPrice"]} ${item["currency"]}"),
              SizedBox(height: 20,),
              // Add to cart button
              ElevatedButton.icon(
                onPressed: () async{
                  print('Add to cart!');
                  await DatabaseService(uid: userId).addToCart(item.id);
                  
                  // Show notification
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Item has been added to cart!"))
                  );
                }, 
                icon: Icon(Icons.add), 
                label: Text("Add to cart")
              ),
            ],
          ),
        ),
      ),
    );
  }
}