import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../scoped-model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/food_item_card.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'All Food Items',
      //     style: TextStyle(
      //         fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
      //   ),
      // ),
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          model.fetchFoods();
          List<Food> foods = model.foods;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: foods.map((Food food) {
                return FoodItemCard(
                  food.name,
                  food.description,
                  food.price.toString(),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

// Container(
// color: Colors.white,
// padding: const EdgeInsets.symmetric(horizontal: 16.0),
// child: ScopedModelDescendant<MainModel>(
// builder: (BuildContext context, Widget child, MainModel model) {
// model.fetchFoods();
// List<Food> foods = model.foods;
// return Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: foods.map((Food food) {
// return FoodItemCard(
// food.name,
// food.description,
// food.price.toString(),
// );
// }).toList(),
// );
// },
// ),
// ),
