// Class that will hold all of the functions related to 
// Firestore databse

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // this variable will hold the user id used for database transactions
  final String uid;

  DatabaseService({ this.uid });

  // Reference point of the users
  // Old code
  // CollectionReference userRef = Firestore.instance.collection('users');
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  // Reference point of the products
  CollectionReference itemRef = FirebaseFirestore.instance.collection('product');
  // Reference point of the product
  CollectionReference cartRef = FirebaseFirestore.instance.collection('cart');

  // add the new user to the firestore
  Future addUserData(String userId, String email, String firstName, String lastName) async {
    return await userRef.doc(userId).set({
      'email': email,
      'firstName': firstName,
      'lastName' : lastName,
    });
  }

  // fetch the user information from the firestore
  Future fetchUserData() async {
    try {
      return await userRef.doc(uid).get();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // fetch the products/items
  Future fetchProducts() async {
    try {
      return await itemRef.get();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Add to cart
  Future addToCart(String itemId) async {
    try {
      return await cartRef.doc().set({
        'itemId' : itemId,
        'userId' : uid,
      });
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Function to fetch the carts
  Stream<QuerySnapshot> fetchCart () {
    try {
      return cartRef.
        where("userId", isEqualTo: uid)
        .snapshots();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Function to fetch the item/product based on the item id
  Future fetchItemInfo(String itemId) async {
    try {
      return await itemRef.doc(itemId).get();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Function that will remove the cart using cart id
  Future removeCart(String cartId) async {
    try {
      return await cartRef.doc(cartId).delete();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}