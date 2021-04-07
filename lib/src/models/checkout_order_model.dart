import 'package:restaurant_app/src/models/food_model.dart';

class CheckoutOrder{

  final String id;
  final List<Food> finalorders;

  CheckoutOrder({
    this.id,
    this.finalorders,
  });
}