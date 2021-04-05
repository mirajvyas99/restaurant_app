import 'package:flutter/material.dart';
import 'package:restaurant_app/src/pages/category_list.dart';
import 'package:restaurant_app/src/scoped-model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'food_card.dart';

class FoodCategory extends StatefulWidget {
  final MainModel model;
  FoodCategory({this.model});
  @override
  _FoodCategoryState createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      widget.model.fetchAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: model.categoryLength,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: FoodCard(
                categoryName: model.categories[index].categoryName,
                imagePath: model.categories[index].imagePath,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CategoryListPage(catId: model.categories[index]),
                ));
              },
            );
          },
        );
        },
      ),
    );
  }
}
