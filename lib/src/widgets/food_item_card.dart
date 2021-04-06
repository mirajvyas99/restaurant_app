import 'package:flutter/material.dart';
import 'small_button.dart';

class FoodItemCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String price;

  FoodItemCard(this.title, this.description,this.imagePath, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 4.0),
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            offset: Offset(0, 5.0),
            color: Colors.black26, //black38
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 90.0,
            height: 90.0,
            margin: EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("$imagePath"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 15.0),
              Flexible(
                child: Container(
                  width: 200.0,
                  child: Text('$description'),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                width: 200.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '₹ $price',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    // SizedBox(width: 20.0),
                    SmallButton(btnText: 'Buy'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
