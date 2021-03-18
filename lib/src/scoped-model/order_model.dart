import 'dart:async';
import 'dart:convert';
import '../models/food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class OrderModel extends Model {
  List<Food> _orders = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<Food> get orders {
    return List.from(_orders);
  }

  int get orderLength {
    return _orders.length;
  }

  Future<bool> addOrder(Food order) async {
    _isLoading = true;
    notifyListeners();

    bool isNewItem = true;

    for(int i=0;i<_orders.length;i++) {
      if(_orders[i].id == order.id){
        if(order.quantity <= 0){
          _orders.remove(i);
        }
        else {
          _orders[i].quantity = order.quantity;
        }
        isNewItem = false;
        break;
      }
    }
    if(isNewItem){
      _orders.add(order);
    }

    try {
      // final Map<String, dynamic> orderData = {
      //   "title": order.name,
      //   "price": order.price,
      //   "discount": order.discount,
      // };
      // final http.Response response = await http.post(
      //     "https://restaurant-app-8548a-default-rtdb.firebaseio.com/orders.json",
      //     body: json.encode(orderData));
      //
      // final Map<String, dynamic> responseData = json.decode(response.body);
      //
      // Food orderWithId = Food(
      //   id: responseData["name"],
      //   name: order.name,
      //   discount: order.discount,
      //   price: order.price,
      // );
      //
      // _orders.add(orderWithId);
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

  Future<bool> fetchOrder() async {
    _isLoading = true;
    notifyListeners();

    try {
      // final http.Response response = await http.get(
      //     "https://restaurant-app-8548a-default-rtdb.firebaseio.com/orders.json");
      //
      // final Map<String, dynamic> fetchedData = json.decode(response.body);
      // // final List<Food> fetchedFoodItems = [];
      //
      // final List<Food> orderItems = [];
      //
      // fetchedData.forEach((String id, dynamic orderData) {
      //   Food orderItem = Food(
      //     id: id,
      //     name: orderData["title"],
      //     price: double.parse(orderData["price"].toString()),
      //     discount: double.parse(orderData["discount"].toString()),
      //   );
      //   orderItems.add(orderItem);
      // });

      // _orders = orderItems;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> deleteOrder(String orderId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final http.Response response = await http.delete(
          "https://restaurant-app-8548a-default-rtdb.firebaseio.com/foods/${orderId}.json");
      //delete item from List of food items
      _orders.removeWhere((Food order) => order.id == orderId);
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Food getOrderItemById(String orderId) {
    Food order;
    for (int i = 0; i < _orders.length; i++) {
      if (_orders[i].id == orderId) {
        order = _orders[i];
        break;
      }
    }
    return order;
  }
}
