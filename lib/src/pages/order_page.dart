import 'package:flutter/material.dart';
import 'package:restaurant_app/src/models/checkout_order_model.dart';
import 'package:restaurant_app/src/models/food_model.dart';
import 'package:restaurant_app/src/models/user_info_model.dart';
import 'package:restaurant_app/src/pages/checkout_page.dart';
import 'package:restaurant_app/src/scoped-model/checkout_order_model.dart';
import 'package:restaurant_app/src/scoped-model/main_model.dart';
import 'package:restaurant_app/src/scoped-model/order_model.dart';
import 'package:restaurant_app/src/utils/preference_helper.dart';
import 'package:restaurant_app/src/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/order_card.dart';

class OrderPage extends StatefulWidget {
  final MainModel model;
  final Food food;

  OrderPage({this.model, this.food});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScopedModelDescendant(
          // rebuildOnChange: false,
          builder: (BuildContext context, Widget child, MainModel model) {
            if (model.orderLength == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.no_food_rounded),
                      iconSize: 50,
                      color: Colors.blue,
                      onPressed: () {},
                    ),
                    Text("Cart is Empty",style: TextStyle(fontSize: 16.0),),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                scrollDirection: Axis.vertical,
                itemCount: model.orderLength,
                itemBuilder: (BuildContext lctx, int index) {
                  return OrderCard(food: model.orders[index]);
                },
              );
            }
          }),
      bottomNavigationBar: _buildTotalContainer(),
    );
  }

  Widget _buildTotalContainer() {
    return ScopedModelDescendant(
      // rebuildOnChange: false,
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
        height: 220.0,
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Subtotal",
                  style: TextStyle(
                    color: Color(0xFF9BA7C6),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  model.orderLength == 0 ? "0.0" : "${model.subtotal}",
                  style: TextStyle(
                    color: Color(0xFF6C6D6D),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Tax (%)",
                  style: TextStyle(
                    color: Color(0xFF9BA7C6),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "5",
                  style: TextStyle(
                    color: Color(0xFF6C6D6D),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Discount (%)",
                  style: TextStyle(
                    color: Color(0xFF9BA7C6),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "10",
                  style: TextStyle(
                    color: Color(0xFF6C6D6D),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              height: 2.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Cart Total",
                  style: TextStyle(
                    color: Color(0xFF9BA7C6),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  model.orderLength == 0 ? "0.0" : "${model.finalbill}",
                  style: TextStyle(
                    color: Colors.black, //Color(0xFF6C6D6D)
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                UserInfo userInfo = model.getUserDetails(PreferenceHelper.getId());
                model.addOrder(CheckoutOrder(id: userInfo.username,finalorders: model.orders,));
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => CheckoutPage()),
                );
              },
              child: Container(
                height: 44.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Center(
                  child: Text(
                    "Proceed To Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      );
    });
  }
}
