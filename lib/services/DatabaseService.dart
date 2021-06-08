// Class that will hold all of the functions related to 
// Firestore databse

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // this variable will hold the user id used for database transactions
  final String uid;

  DatabaseService({ this.uid });

  // Reference point of the users
  CollectionReference userRef = Firestore.instance.collection('users');
  // Reference point of the products
  CollectionReference itemRef = Firestore.instance.collection('product');
  // Reference point of the product
  CollectionReference cartRef = Firestore.instance.collection('cart');

  // add the new user to the firestore
  Future addUserData(String userId, String email, String firstName, String lastName) async {
    return await userRef.document(userId).setData({
      'email': email,
      'firstName': firstName,
      'lastName' : lastName,
    });
  }

  // fetch the user information from the firestore
  Future fetchUserData() async {
    try {
      return await userRef.document(uid).get();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // fetch the products/items
  Future fetchProducts() async {
    try {
      return await itemRef.getDocuments();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Add to cart
  Future addToCart(String itemId) async {
    try {
      return await cartRef.document().setData({
        'itemId' : itemId,
        'userId' : uid,
      });
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}