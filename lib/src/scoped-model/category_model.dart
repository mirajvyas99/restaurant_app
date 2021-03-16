import 'dart:convert';

import 'package:restaurant_app/src/models/category_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class CategoryModel extends Model{

  List<Category> _categories = [
    Category(
        imagePath: "assets/images/soup.png",
        categoryName: "Soups"),
    Category(
        imagePath: "assets/images/starter.png",
        categoryName: "Starters"),
    Category(
        imagePath: "assets/images/indianbread.png",
        categoryName: "Indian Bread"),
    Category(
        imagePath: "assets/images/pizza.png",
        categoryName: "Pizza"),
    Category(
        imagePath: "assets/images/burger.png",
        categoryName: "Burger"),
    Category(
        imagePath: "assets/images/coffee-cup.png",
        categoryName: "Coffee Cup"),
    Category(
        imagePath: "assets/images/softdrink.png",
        categoryName: "Soft Drinks"),
    Category(
        imagePath: "assets/images/desert.png",
        categoryName: "Deserts"),
  ];

  bool _isLoading = false;

  List<Category> get categories {
    return List.from(_categories);
  }

  category(Category categories) {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> categoryData = {
        "category": categories.categoryName,
      };
      http.post(
          "https://restaurant-app-8548a-default-rtdb.firebaseio.com/categories.json",
          body: json.encode(categoryData));

      // final Map<String, dynamic> responseData = json.decode(response.body);

      // Food foodWithId = Food(
      //   id: responseData["name"],
      //   name: food.name,
      //   description: food.description,
      //   category: food.category,
      //   discount: food.discount,
      //   price: food.price,
      // );

      // _foods.add(foodWithId);
      _isLoading = false;
      notifyListeners();
      // fetchFoods();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
      // print("Connection Error : $e");
    }
  }

}