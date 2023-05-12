import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project1/Classes/Category.dart';
import 'package:flutter_project1/Classes/ChainStore.dart';
import 'package:flutter_project1/Classes/Price.dart';
import 'package:flutter_project1/Classes/Product.dart';
import 'package:flutter_project1/Classes/Promotion.dart';

import 'User.dart';

class DBConnection {
  static var productsSet = <Product>{};
  static var categories=<Category>{};
  static var promotions=<Promotion>{};
  static var stores=<ChainStore>{};
  static var prices=<Price>{};
  static bool Return = false;

  static Future<void> getStores() async{
    FirebaseFirestore.instance.collection('chainsOfStore').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          ChainStore instance = ChainStore.fromFirestore(docSnapshot);
          stores.add(instance);
          print(instance.title);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  static void getProducts(){
    FirebaseFirestore.instance.collection('products').get().then(
      (querySnapshot){
        for (var docSnapshot in querySnapshot.docs) {
          Product instance = Product.fromFirestore(docSnapshot);
          instance.setID(docSnapshot.id.toString());
          productsSet.add(instance);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  static bool checkUser(email, password){
    FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          if(docSnapshot.get('password') == password){
            setReturn(true);
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return Return;
  }
  static void getCategories(){
    FirebaseFirestore.instance.collection('category').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Category instance = Category.fromFirestore(docSnapshot);
          instance.setID(docSnapshot.id);
          categories.add(instance);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  static void getPrices(){
     FirebaseFirestore.instance.collection('prices').get().then(
      (querySnapshot){
        for (var docSnapshot in querySnapshot.docs) {
          Price instance = Price.fromFirestore(docSnapshot);
          prices.add(instance);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  static void getPromotions(){
    FirebaseFirestore.instance.collection('promotions').get().then(
      (querySnapshot){
        for (var docSnapshot in querySnapshot.docs) {
          Promotion instance = Promotion.fromFirestore(docSnapshot);
          promotions.add(instance);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  static void setReturn(Return){
    DBConnection.Return=Return;
  }
}
