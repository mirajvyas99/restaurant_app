import 'package:flutter/material.dart';
import 'package:restaurant_app/src/pages/signin_page.dart';
import 'package:restaurant_app/src/scoped-model/main_model.dart';
import 'package:restaurant_app/src/screens/main_screen.dart';
import 'package:restaurant_app/src/utils/preference_helper.dart';
import 'package:scoped_model/scoped_model.dart';

class SplashScreen extends StatefulWidget {
  final MainModel mainModel;
  SplashScreen({this.mainModel});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2),(){
      PreferenceHelper.load().whenComplete((){
        print(PreferenceHelper.getLoggedIn().toString());
        if(PreferenceHelper.getLoggedIn() == true) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainScreen(model: this.widget.mainModel)
          ));
        }else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SignInPage()
          ));
        }
      });
    },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: widget.mainModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image(
            image: AssetImage("assets/images/ic_launcher.png"),
          ),
        ),
      ),
    );
  }
}
