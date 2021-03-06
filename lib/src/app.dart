import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/admin/pages/add_food_item.dart';
import 'screens/main_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food Delivery App",
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      // home: AddFoodItem(),
    );
  }
}
