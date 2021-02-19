import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import "src/app.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}