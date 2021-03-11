import 'package:flutter/material.dart';
import 'package:restaurant_app/src/pages/signin_page.dart';
import 'package:restaurant_app/src/scoped-model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;

  CustomListTile({this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model){
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: GestureDetector(
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  "$text",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            onTap: (){
              if("$text" == "Logout"){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignInPage()));
                model.logout();
              }
            },
          ),
        );
      }
    );
  }
}
