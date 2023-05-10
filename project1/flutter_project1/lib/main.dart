import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Pages/LoginPage.dart';
import 'package:flutter_project1/Widgets/MainStructElement.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCQUEFQtx480-qACKVb1aeK84aX-vdmYMM',
          appId: '1:583814684655:android:b91aec8ff5c365f52aa01a',
          messagingSenderId: '583814684655',
          projectId: 'smartcatalog-b5270',
          storageBucket: 'smartcatalog-b5270.appspot.com'
          ));
  DBConnection.getCategories();
  DBConnection.getProducts();
  DBConnection.getStores();
  DBConnection.getPromotions();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}
