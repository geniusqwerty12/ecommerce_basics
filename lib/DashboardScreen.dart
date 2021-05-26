import 'package:ecommerce_basics_1/services/AuthService.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Dashboard"),
      ),
      body: Container(
        child: Column(
          children: [
            // Logout button
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
      ),
    );
  }
}