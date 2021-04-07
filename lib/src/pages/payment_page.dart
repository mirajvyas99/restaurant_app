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
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text("Payment Methods", style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  height:100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1.0, color: Colors.white),
                  ),
                  child: Image.network("https://www.searchpng.com/wp-content/uploads/2019/02/Paytm-Logo-With-White-Border-PNG-image.png",fit: BoxFit.contain,),
                ),
                Text("Accepted Here", style: TextStyle(color: Colors.black, fontSize: 30.0)),
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
                Text("OR", style: TextStyle(color: Colors.black, fontSize: 20.0)),
                Text("Enter Mobile Number", style: TextStyle(color: Colors.black, fontSize: 20.0)),
                SizedBox(height: 20,),
                Text("____________",style: TextStyle(color: Colors.black, fontSize: 20.0)),
                SizedBox(height: 20,),
                Text("8141418054",style: TextStyle(color: Colors.black, fontSize: 30.0)),
                Text("____________",style: TextStyle(color: Colors.black, fontSize: 20.0)),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
