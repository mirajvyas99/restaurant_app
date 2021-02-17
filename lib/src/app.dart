import 'package:flutter/material.dart';
import 'homescreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food Delivery App",
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent
      ),
      home: HomeScreen(),
    );
  }
}
