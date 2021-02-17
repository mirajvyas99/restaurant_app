import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {

  final String categoryName;
  final String imagePath;
  final int numberOfItems;

  FoodCard({this.categoryName,this.imagePath,this.numberOfItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Card(
        shadowColor: Colors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage(imagePath),
                height: 65,
                width: 65,
              ),
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(categoryName, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Text("$numberOfItems Kinds"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
