import 'dart:convert';
import 'package:food_app_flutter_zone/src/models/food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class FoodModel extends Model {
  List<Food> _foods = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<Food> get foods {
    return List.from(_foods);
  }

  Future<bool> addFood(Food food) async {
    // _foods.add(food);
    _isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> foodData = {
        "title": food.name,
        "description": food.description,
        "category": food.category,
        "price": food.price,
        "discount": food.discount,
      };
      final http.Response response = await http.post(
          "https://restaurant-app-cb62a-default-rtdb.firebaseio.com/foods.json",
          body: json.encode(foodData));

      final Map<String, dynamic> responseData = json.decode(response.body);

      Food foodWithId = Food(
        id: responseData["name"],
        name: food.name,
        description: food.description,
        category: food.category,
        discount: food.discount,
        price: food.price,
      );
      _isLoading = false;
      notifyListeners();
      fetchFoods();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
      // print("Connection Error : $e");
    }
  }

  void fetchFoods() {
    http
        .get(
            "https://restaurant-app-cb62a-default-rtdb.firebaseio.com/foods.json")
        .then((http.Response response) {
      final Map<String, dynamic> fetchedData = json.decode(response.body);
      final List<Food> fetchedFoodItems = [];

      final List<Food> foodItems = [];

      fetchedData.forEach((String id, dynamic foodData) {
        Food foodItem = Food(
          id: id,
          name: foodData["title"],
          description: foodData["description"],
          category: foodData["category"],
          price: foodData["price"],
          discount: foodData["discount"],
        );
        foodItems.add(foodItem);
      });
      _foods = foodItems;
      notifyListeners();
    });
  }
}
