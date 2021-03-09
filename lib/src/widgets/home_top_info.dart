import 'package:flutter/material.dart';

class HomeTopInfo extends StatelessWidget {
  final textStyle = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    // color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "What would",
                style: textStyle,
              ),
              Text(
                "you like to eat?",
                style: textStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
