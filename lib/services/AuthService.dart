import 'package:firebase_auth/firebase_auth.dart';

// Auth service to contain all of the functions related to authentication
class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Log in function
  Future loginUser(String email, String password) async {
    try {
      // Call the firebase function to login
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(result.user);
      return result.user;
    } catch(e) {
      print("Error logging in");
      print(e);
      return null;
    }
  }

  // Register function
    Future registerUser(String email, String password) async {
    try {
      // Call the firebase function to login
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(result.user);
      return result.user;
    } catch(e) {
      print("Error logging in");
      print(e);
      return null;
    }
  }

  // Logout
}