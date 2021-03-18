import 'food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'category_model.dart';
import 'user_scoped_model.dart';
import 'order_model.dart';

class MainModel extends Model with FoodModel, UserModel, OrderModel {
  void fetchAll() {
    fetchFoods();
    fetchUserInfos();
    // fetchCategory();
    fetchOrder();
  }
}
