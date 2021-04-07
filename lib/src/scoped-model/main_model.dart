import 'package:restaurant_app/src/scoped-model/category_model.dart';
import 'package:restaurant_app/src/scoped-model/checkout_order_model.dart';
import 'food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'user_scoped_model.dart';
import 'order_model.dart';

class MainModel extends Model with FoodModel, UserModel, OrderModel, CategoryModel, CheckoutOrderModel {
  void fetchAll() {
    fetchFoods();
    fetchUserInfos();
    fetchCategories();
  }
}
