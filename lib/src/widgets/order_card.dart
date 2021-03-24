import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/src/models/food_model.dart';
import 'package:restaurant_app/src/scoped-model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderCard extends StatefulWidget {
  final Food food;
  OrderCard({this.food});
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model){
        return Card(
            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFD3D3D3), width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    width: 50.0,
                    height: 70.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // InkWell(
                          //     onTap: () {},
                          //     child: Icon(Icons.keyboard_arrow_up,
                          //         color: Color(0xFFD3D3D3))),
                          Text(
                            "${widget.food.quantity}",
                            style: TextStyle(fontSize: 18.0, color: Colors.black),
                          ),
                          // InkWell(
                          //     onTap: () {},
                          //     child: Icon(Icons.keyboard_arrow_down,
                          //         color: Color(0xFFD3D3D3))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    height: 70.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("${widget.food.imagePath}"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(35.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 5.0,
                              offset: Offset(0.0, 2.0))
                        ]),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${widget.food.name}",
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "₹ ${widget.food.price * widget.food.quantity}",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  Spacer(),
                  // IconButton(
                  //   icon: Icon(Icons.cancel,color: Colors.red.shade300,),
                  //   color: Colors.grey,
                  //   onPressed: (){
                  //     widget.food.quantity = 0;
                  //     // print("button - ${widget.food.quantity}");
                  //     model.addOrder(widget.food);
                  //   }
                  // ),
                  GestureDetector(
                    onTap: () {
                      widget.food.quantity = 0;
                      // print("button - ${widget.food.quantity}");
                      model.addCart(widget.food);
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red.shade300,
                    ),
                  ),
                ],
              ),
            ),
          );
      }
    );
  }
}
