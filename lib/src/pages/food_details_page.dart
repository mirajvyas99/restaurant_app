import 'package:flutter/material.dart';
import 'package:restaurant_app/src/scoped-model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/button.dart';
import '../models/food_model.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;
  FoodDetailsPage({this.food});

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int _counter = 1;


  var _mediumSpace = SizedBox(
    height: 20.0,
  );

  var _smallSpace = SizedBox(
    height: 10.0,
  );

  var _largeSpace = SizedBox(
    height: 50.0,
  );

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Food Details",
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 400.0,
                  child: Image.network(
                    "${widget.food.imagePath}",
                    fit: BoxFit.cover,
                  ),
                ),
                _mediumSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${widget.food.name}",
                      style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold,),
                    ),
                    Text(
                      "₹ ${widget.food.price}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16.0),
                    ),
                  ],
                ),
                _mediumSpace,
                Text(
                  "Description",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _smallSpace,
                Text(
                  "${widget.food.description}",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  textAlign: TextAlign.justify,
                ),
                _mediumSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove_circle,color: Colors.red,),
                      onPressed: _decrementCounter,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                     "$_counter" ,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle,color: Colors.green,),
                      onPressed: _incrementCounter,
                    ),
                  ],
                ),
                _largeSpace,
                // Button(btnText: "Add to Cart"),
                _buildAddToCartButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return ScopedModelDescendant(
        builder: (BuildContext sctx, Widget child, MainModel model) {
      return GestureDetector(
        onTap: () {
          SnackBar snackBar = SnackBar(
            content: Text("Added to cart",style: TextStyle(color: Colors.white, fontSize: 16.0),),
            duration: Duration(seconds:1),
          );
          widget.food.quantity = _counter;
          print(widget.food.id);
          model.addCart(widget.food);
        },
        child: Button(btnText: "Add to Cart"),
      );
    });
  }
}
