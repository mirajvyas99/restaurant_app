import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/admin/pages/add_food_item.dart';
import '../models/food_model.dart';
import '../scoped-model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/food_item_card.dart';

class FavoritePage extends StatefulWidget {
  final MainModel model;
  FavoritePage({this.model});
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  //scaffold global key
  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.model.fetchFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _explorePageScaffoldKey,
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          // model.fetchFoods(); //this will fetch and notifyListeners() will be called
          // List<Food> foods = model.foods;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: RefreshIndicator(
              onRefresh: model.fetchFoods,
              child: ListView.builder(
                itemCount: model.foodLength,
                itemBuilder: (BuildContext lctx, int index) {
                  return GestureDetector(
                    onTap: () async {
                      final bool response = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddFoodItem(food: model.foods[index]),
                        ),
                      );
                      if (response) {
                        SnackBar snackBar = SnackBar(
                          duration: Duration(seconds: 2),
                          backgroundColor: Theme.of(context).primaryColor,
                          content: Text(
                            "Food item successfully updated.",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        );
                        _explorePageScaffoldKey.currentState
                            .showSnackBar(snackBar);
                      }
                    },
                    child: FoodItemCard(
                      model.foods[index].name,
                      model.foods[index].description,
                      model.foods[index].price.toString(),
                    ),
                  );
                },
              ),
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
