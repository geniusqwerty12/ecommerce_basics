import 'package:flutter/material.dart';

// Dashboard Widget
class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Dashboard"),
      ),
      body: Center(
        child: Text("My Dashboard"),
      ),
    );
  }
}