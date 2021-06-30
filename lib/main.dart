import 'package:ecommerce_basics_1/DashboardScreen.dart';
import 'package:ecommerce_basics_1/ItemInfoScreen.dart';
import 'package:ecommerce_basics_1/authenticationScreen.dart';
import 'package:ecommerce_basics_1/cartScreen.dart';
import 'package:ecommerce_basics_1/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// TODOs
// Create an application that has two screens, Login and Sign up - done
// Toggle in between the Screens - done
// Add form fields - done
// Add form field validation - done
// Add a simple design - done
// Update validation - done
// Integrate Firebase to enalbe the Login/Sign up functionalities
  // Add dependency and service files
  // Add functionality on Login page
  // Add functionality on Sign up page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: AuthenticationScreen(),

      // Change the initial route/page to Splashscreen
      initialRoute: 'splash',
      routes: {
        'splash': (context) => SplashScreen(),
        'auth': (context) => AuthenticationScreen(),
        'dash': (context) => DashboardScreen(),
        'itemInfo' : (context) => ItemInfoScreen(),
        'cart' : (context) => CartScreen(),
      },
    );
  }
}
