import 'dart:async';
import 'dart:convert';
import 'package:restaurant_app/src/models/checkout_order_model.dart';
import '../models/food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class CheckoutOrderModel extends Model {
  // List<CheckoutOrder> _finalorder = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }
  //
  // List<Food> get finalorder {
  //   return List.from(_finalorder);
  // }
  //
  // int get finalorderLength {
  //   return _finalorder.length;
  // }

  Future<bool> addOrder(CheckoutOrder checkoutOrder) async {
    _isLoading = true;
    notifyListeners();

    try {

      for(int z = 0; z < checkoutOrder.finalorders.length; z++){
        final Map<String, dynamic> foodData = {
          "name": checkoutOrder.finalorders[z].name,
          "quantity": checkoutOrder.finalorders[z].quantity,
        };
        // final http.Response response =
        await http.post(
            "https://restaurant-app-8548a-default-rtdb.firebaseio.com/orders/${checkoutOrder.id}.json",
            body: json.encode(foodData));
      }


      // final Map<String, dynamic> responseData = json.decode(response.body);
      //
      // CheckoutOrder orderWithId = CheckoutOrder(
      //   id: responseData["name"],
      //   name: checkoutOrder.name,
      //   quantity: checkoutOrder.quantity,
      // );

      // _finalorder.add(orderWithId);
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

  // Future<bool> fetchOrders() async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final http.Response response = await http.get(
  //         "https://restaurant-app-8548a-default-rtdb.firebaseio.com/orders.json");
  //
  //     final Map<String, dynamic> fetchedData = json.decode(response.body);
  //
  //     final List<CheckoutOrder> orderItems = [];
  //
  //     fetchedData.forEach((String id, dynamic orderData) {
  //       CheckoutOrder orderItem = CheckoutOrder(
  //         id: id,
  //         name: orderData["title"],
  //         userName: orderData["userName"],
  //         quantity: int.parse(orderData["quantity"].toString()),
  //       );
  //       orderItems.add(orderItem);
  //     });
  //
  //     _finalorder = orderItems;
  //     _isLoading = false;
  //     notifyListeners();
  //     return Future.value(true);
  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();
  //     return Future.value(false);
  //   }
  // }
  //
  // Future<bool> updateOrder(Map<String, dynamic> orderData, String orderId) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   //get the food by id
  //   CheckoutOrder theFood = getOrderItemById(orderId);
  //
  //   //get the index of the food
  //   int orderIndex = _finalorder.indexOf(theFood);
  //   try {
  //     await http.put(
  //         "https://restaurant-app-8548a-default-rtdb.firebaseio.com/foods/${orderId}.json",
  //         body: json.encode(orderData));
  //
  //     CheckoutOrder updateOrderItem = CheckoutOrder(
  //       id: orderId,
  //       name: orderData["title"],
  //       username: orderData["username"],
  //       quantity: orderData["quantity"],
  //     );
  //
  //     _finalorder[orderIndex] = updateOrderItem;
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
  // Future<bool> deleteOrder(String orderId) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   String imageUrl;
  //   try {
  //     final http.Response response = await http.delete(
  //         "https://restaurant-app-8548a-default-rtdb.firebaseio.com/foods/${orderId}.json");
  //
  //     //delete item from List of food items
  //     _finalorder.removeWhere((CheckoutOrder checkoutOrder) => checkoutOrder.id == orderId);
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
  // CheckoutOrder getOrderItemById(String orderId) {
  //   CheckoutOrder checkoutOrder;
  //   for (int i = 0; i < _finalorder.length; i++) {
  //     if (_finalorder[i].id == orderId) {
  //       checkoutOrder = _finalorder[i];
  //       break;
  //     }
  //   }
  //   return checkoutOrder;
  // }
}
