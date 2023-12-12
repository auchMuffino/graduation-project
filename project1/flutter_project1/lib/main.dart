import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';   
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Classes/firebase_streem.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  init();
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Color(0xFF4EC88C),
    ),
    debugShowCheckedModeBanner: false,
    home: FirebaseStream(),
  ));
  
}
  void init(){
  DBConnection.getCategories();
  DBConnection.getStores();
  DBConnection.getProducts();
  DBConnection.getPromotions(); 
  DBConnection.getPrices();
}