import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Payment Methods", style: TextStyle(color: Colors.black, fontSize: 30.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.0, color: Colors.white),
                ),
                child: Image.asset("assets/images/qrcode.png",fit: BoxFit.contain,),
              ),
              SizedBox(height: 20,),
              Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.0, color: Colors.black),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.0, color: Colors.black,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
