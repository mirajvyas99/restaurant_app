import 'package:flutter/material.dart';
import 'package:restaurant_app/src/screens/splash_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scoped-model/main_model.dart';
import 'screens/main_screen.dart';

class App extends StatelessWidget {
  final MainModel mainModel = MainModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        title: "Food Delivery App",
        theme: ThemeData(primaryColor: Colors.blueAccent),
        debugShowCheckedModeBanner: false,

        initialRoute: "/",
        routes: {
          "/" : (BuildContext context) => SplashScreen(mainModel: mainModel),
          "/mainscreen" : (BuildContext context) => MainScreen(model: mainModel,),
        },
      ),
    );
  }
}
