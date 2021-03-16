import 'food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'category_model.dart';
import 'user_scoped_model.dart';

class MainModel extends Model with FoodModel, UserModel, CategoryModel {
  void fetchAll() {
    fetchFoods();
    fetchUserInfos();
    // fetchCategory();
  }
}
