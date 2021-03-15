import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/src/admin/pages/add_food_item.dart';
import '../models/food_model.dart';
import '../scoped-model/food_model.dart';
import '../scoped-model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/food_item_card.dart';
import '../widgets/show_dialog.dart';
import 'food_details_page.dart';

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
    if (widget.model != null) {
      widget.model.fetchFoods();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _explorePageScaffoldKey,
      backgroundColor: Colors.white,
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
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => FoodDetailsPage(
                          food: model.foods[index],
                        ),
                      ));
                    },
                    onLongPress: () async {
                      final bool response =
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => AddFoodItem(
                                    food: model.foods[index],
                                  )));
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
                    onDoubleTap: () {
                      //delete food item
                      showLoadingIndicator(context, "Deleting Food Item...");
                      model
                          .deleteFood(model.foods[index].id)
                          .then((bool response) {
                        Navigator.of(context).pop();
                      });
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
