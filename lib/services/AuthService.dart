import 'package:ecommerce_basics_1/services/DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Auth service to contain all of the functions related to authentication
class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Log in function
  Future loginUser(String email, String password) async {
    try {
      // Call the firebase function to login
      // Old code
      // AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(result.user);
      return result.user;
    } catch(e) {
      print("Error logging in");
      print(e);
      return null;
    }
  }

  // Register function
    Future registerUser(String email, String password, String firstName, String lastName) async {
    try {
      // Call the firebase function to login
      // Old code
      // AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(result.user);

      // Database Service class
      DatabaseService _databaseService = DatabaseService();
      await _databaseService.addUserData(result.user.uid, email, firstName, lastName);

      return result.user;
    } catch(e) {
      print("Error logging in");
      print(e);
      return null;
    }
  }

  // Logout
  Future logoutUser() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Check if the user signed in previously
  Future isLoggedIn() async {
    try {
      // Firebase will get the user from the disk cache
      // Old code
      // FirebaseUser user = await _auth.currentUser();
      User user = _auth.currentUser;
      print(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}