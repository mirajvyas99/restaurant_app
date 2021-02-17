import 'package:flutter/material.dart';

class HomeTopInfo extends StatelessWidget {

  final textStyle =  TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("What would", style: textStyle),
              Text("you like to eat?", style: textStyle,),
            ],
          ),
          Icon(Icons.notifications_none,size: 30,color: Theme.of(context).primaryColor,),
        ],
      ),
    );
  }
}
