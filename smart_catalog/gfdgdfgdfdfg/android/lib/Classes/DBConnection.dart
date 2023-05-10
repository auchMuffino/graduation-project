import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project1/Classes/Products.dart';

import 'Users.dart';

class DBConnection {
  static var productsSet = <Product>{};
  static bool Return = false;

  static Future<void> getProducts() async {
    FirebaseFirestore.instance.collection('products').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Product instance = Product.fromFirestore(docSnapshot);
          instance.setID(docSnapshot.id.toString());
          productsSet.add(instance);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  static bool checkUser(email, password) {
    // bool Rreturn=false;
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
  static void setReturn(Return){
    DBConnection.Return=Return;
  }
}
