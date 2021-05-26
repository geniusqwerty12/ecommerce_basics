// Class that will hold all of the functions related to 
// Firestore databse

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  // Reference point of the users
  CollectionReference userRef = Firestore.instance.collection('users');

  // add the new user to the firestore
  Future addUserData(String userId, String email, String firstName, String lastName) async {
    return await userRef.document(userId).setData({
      'email': email,
      'firstName': firstName,
      'lastName' : lastName,
    });
  }
}