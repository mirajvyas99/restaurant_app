import 'dart:convert';
import 'package:restaurant_app/src/models/category_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class CategoryModel extends Model {
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }


  List<Category> _categories = [];
  List<Category> get categories {
    return List.from(_categories);
  }
  int get categoryLength {
    return _categories.length;
  }


  // List<Food> _categoryData = [];
  // List<Food> get categoryData {
  //   return List.from(_categoryData);
  // }
  // int get categoryDataLength {
  //   return _categoryData.length;
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

  // Future<bool> fetchCategoryData() async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final http.Response response = await http.get(
  //         "https://restaurant-app-8548a-default-rtdb.firebaseio.com/foods.json");
  //
  //     final Map<String, dynamic> fetchedData = json.decode(response.body);
  //
  //     final List<Food> catDataItems = [];
  //
  //     fetchedData.forEach((String id, dynamic foodData) {
  //       Food catDataItem = Food(
  //         id: id,
  //         name: foodData["title"],
  //         catId: foodData["catId"],
  //         imagePath: foodData["imagePath"],
  //         description: foodData["description"],
  //         price: double.parse(foodData["price"].toString()),
  //         discount: double.parse(foodData["discount"].toString()),
  //       );
  //       catDataItems.add(catDataItem);
  //     });
  //
  //     _categoryData = catDataItems;
  //     _isLoading = false;
  //     notifyListeners();
  //     return Future.value(true);
  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();
  //     return Future.value(false);
  //   }
  // }
}
