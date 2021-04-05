import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:restaurant_app/src/models/category_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class CategoryModel extends Model {
  List<Category> _categories = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<Category> get categories {
    return List.from(_categories);
  }

  int get categoryLength {
    return _categories.length;
  }

  // Future<bool> addFood(Category category) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final Map<String, dynamic> foodData = {
  //       "title": food.name,
  //       "imagePath": food.imagePath,
  //       "description": food.description,
  //       "category": food.category,
  //       "price": food.price,
  //       "discount": food.discount,
  //     };
  //     final http.Response response = await http.post(
  //         "https://restaurant-app-8548a-default-rtdb.firebaseio.com/foods.json",
  //         body: json.encode(foodData));
  //
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //
  //     Food foodWithId = Food(
  //       id: responseData["name"],
  //       name: food.name,
  //       imagePath: food.imagePath,
  //       description: food.description,
  //       category: food.category,
  //       discount: food.discount,
  //       price: food.price,
  //     );
  //
  //     _foods.add(foodWithId);
  //     _isLoading = false;
  //     notifyListeners();
  //     // fetchFoods();
  //     return Future.value(true);
  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();
  //     return Future.value(false);
  //     // print("Connection Error : $e");
  //   }
  // }

  Future<bool> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {

      // FirebaseStorage reference = FirebaseStorage.instance;
      // final imgref = reference.ref().child('coffee-cup.png');
      // // no need of the file extension, the name will do fine.
      // var url = await imgref.getDownloadURL();
      // print(url);

      final http.Response response = await http.get(
          "https://restaurant-app-8548a-default-rtdb.firebaseio.com/categories.json");

      final Map<String, dynamic> fetchedData = json.decode(response.body);

      final List<Category> catItems = [];

      fetchedData.forEach((String id, dynamic catData) {
        Category catItem = Category(
          catId: catData["catId"],
          categoryName: catData["categoryName"],
          imagePath: catData["imagePath"],
        );
        catItems.add(catItem);
      });

      _categories = catItems;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  // Future<bool> updateFood(Map<String, dynamic> foodData, String foodId) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   //get the food by id
  //   Food theFood = getFoodItemById(foodId);
  //
  //   //get the index of the food
  //   int foodIndex = _foods.indexOf(theFood);
  //   try {
  //     await http.put(
  //         "https://restaurant-app-8548a-default-rtdb.firebaseio.com/foods/${foodId}.json",
  //         body: json.encode(foodData));
  //
  //     Food updateFoodItem = Food(
  //       id: foodId,
  //       name: foodData["title"],
  //       imagePath: foodData['imagePath'],
  //       category: foodData['category'],
  //       discount: foodData['discount'],
  //       price: foodData['price'],
  //       description: foodData['description'],
  //     );
  //
  //     _foods[foodIndex] = updateFoodItem;
  //
  //     _isLoading = false;
  //     notifyListeners();
  //     return Future.value(true);
  //   } catch (error) {
  //     _isLoading = false;
  //     notifyListeners();
  //     return Future.value(false);
  //   }
  // }
  //
  // Future<bool> deleteFood(String foodId) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   String imageName;
  //   try {
  //     final http.Response response = await http.delete(
  //         "https://restaurant-app-8548a-default-rtdb.firebaseio.com/foods/${foodId}.json");
  //
  //     //delete item from List of food items
  //     // _foods.removeWhere((Food food) => food.id == foodId);
  //
  //     //delete item from List of food items
  //     for (int i = 0; i < _foods.length; i++) {
  //       if (_foods[i].id == foodId) {
  //         imageName = _foods[i].imagePath.split('/').last;
  //         imageName = imageName.replaceAll(new RegExp(r'%2F'), '/');
  //         imageName = imageName.replaceAll(new RegExp(r'(\?alt).*'), '');
  //         print(imageName);
  //
  //         _foods.removeAt(i);
  //       }
  //     }
  //     //delete same image from storage
  //     Reference ref = await FirebaseStorage.instance.ref();
  //     print("reference = $imageName");
  //     ref.child("$imageName").delete();
  //
  //     _isLoading = false;
  //     notifyListeners();
  //     return Future.value(true);
  //   } catch (error) {
  //     _isLoading = false;
  //     notifyListeners();
  //     return Future.value(false);
  //   }
  // }
  //
  // Food getFoodItemById(String foodId) {
  //   Food food;
  //   for (int i = 0; i < _foods.length; i++) {
  //     if (_foods[i].id == foodId) {
  //       food = _foods[i];
  //       break;
  //     }
  //   }
  //   return food;
  // }
}
