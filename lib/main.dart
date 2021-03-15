import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/src/utils/preference_helper.dart';
import "src/app.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceHelper.load();
  await Firebase.initializeApp();
  runApp(App());
}