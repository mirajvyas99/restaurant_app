import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/scoped-model/food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'admin/pages/add_food_item.dart';
import 'scoped-model/main_model.dart';
import 'screens/main_screen.dart';

class App extends StatelessWidget {
  final MainModel mainModel = MainModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        title: "Food Delivery App",
        debugShowCheckedModeBanner: false,
        home: MainScreen(model: mainModel),
        // home: AddFoodItem(),
      ),
    );
  }
}
