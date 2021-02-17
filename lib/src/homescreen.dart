import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/food_category.dart';
import 'widgets/home_top_info.dart';
import 'widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: ListView(
        padding: EdgeInsets.only(top: 50,left: 20,right: 20),
        children: <Widget>[
          HomeTopInfo(),
          FoodCategory(),
          SizedBox(height: 20,),
          SearchField(),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Frequently Bought Foods",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
              GestureDetector(
                onTap: (){},
                child: Text(
                  "View All",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
