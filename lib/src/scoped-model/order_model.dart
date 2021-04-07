import 'dart:async';
import '../models/food_model.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderModel extends Model {
  List<Food> _orders = [];

  double sum;
  double finalsum;
  double finaltotal;

  double get subtotal{
    double sum1 = 0;
    print("LENGTH : ${_orders.length}");
    for(int k=0;k < _orders.length;k++){
      sum1 += _orders[k].quantity * _orders[k].price;

      print(k);
      print(sum1);
    }
    sum = sum1;
    return sum1;
  }

  double get finalbill{
    finalsum = sum + (sum * 0.05);
    finaltotal = finalsum - (finalsum*0.1);
    return finaltotal;
  }

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

  Future<bool> addCart(Food order) async {
    _isLoading = true;
    notifyListeners();

    bool isNewItem = true;

    for (int i = 0; i <_orders.length; i++) {
      if (_orders[i].id == order.id) {
        // print("order quantity - ${order.quantity <=0 }");
        if (order.quantity <= 0) {
          // print("before Size $orderLength");
          _orders.removeAt(i);
          // print("after Size $orderLength");
        } else {
          _orders[i].quantity = order.quantity;
        }
        isNewItem = false;
        break;
      }
    }
    // print("New item : $isNewItem");
    if (isNewItem) {
      _orders.add(order);
    }
    for(int j = 0;j<_orders.length;j++){
      // print("ID : ${_orders[j].id}  ${order.id}, Quant : ${_orders[j].quantity}");
    }
    // print("Size $orderLength");
    try {
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

  Future<bool> logoutCart() async {
    _isLoading = true;
    notifyListeners();

    _orders.clear();

    try {
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }
}
