import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.fastfood),
                iconSize: 80,
                color: Colors.blue,
                onPressed: () {},
              ),
              SizedBox(
                height: 10,
              ),
              Text("Sit Tight!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Text("Your food is on its way...",
                  style: TextStyle(fontSize: 25)),
            ],
          ),
        ),
      ),
    );
  }
}
