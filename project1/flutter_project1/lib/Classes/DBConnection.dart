
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project1/Classes/ListContent.dart';
import 'package:flutter_project1/Classes/firebase_streem.dart';

import '../Pages/ProductsPage.dart';
import '../Tables/Category.dart';
import '../Tables/ChainStore.dart';
import '../Tables/Price.dart';
import '../Tables/Product.dart';
import '../Tables/Promotion.dart';
import '../Tables/User.dart';

class DBConnection {
  static Map<String, Product> productsSet = {};
  static Map<String, Category> categories = {};
  static var promotions = <Promotion>{};
  static  Map<String, ChainStore> stores = {};
  static var prices = <Price>{};

  static Future<bool> getStores() async{
    DBConnection.stores.clear();
    bool a=await FirebaseFirestore.instance.collection('chainsOfStore').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          ChainStore instance = ChainStore.fromFirestore(docSnapshot);
          stores.addAll({instance.UNP : instance});
          print(instance.title);
        }
        return true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return a;
  }

  static Future<bool> getProducts() async{
    DBConnection.productsSet.clear();
    bool a= await FirebaseFirestore.instance.collection('products').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Product instance = Product.fromFirestore(docSnapshot);
          instance.setID(docSnapshot.id.toString());
          productsSet.addAll({docSnapshot.id.toString(): instance});
        }
        return true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return a;
  }

  static Future<void> checkUser() async{
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
            FirebaseStream.currentUser = new UserCatalog.fromFirestore(docSnapshot);
            FirebaseStream.currentUser.setID(docSnapshot.id);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    State<ProductsPage> createState() => ProductsPageState();
  }

  static Future<void> registerUser() async{
    final userData={'email' : FirebaseAuth.instance.currentUser?.email, 'favoriteProducts':List.empty(growable: true)};
    bool ret = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then(
          (querySnapshot){
            if(querySnapshot.size > 0)
              return true;
            return false;
          },
      onError: (e) => print("Error completing: $e"),
    );
    if(ret){
      return;
    } else{
      FirebaseFirestore.instance
        .collection('users')
        .add(userData);
      }
  }

  static Future<bool> getCategories() async{
    DBConnection.categories.clear();
    bool a=await
    FirebaseFirestore.instance.collection('category').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Category instance = Category.fromFirestore(docSnapshot);
          instance.setID(docSnapshot.id);
          categories.addAll({docSnapshot.id: instance});
        }
        return true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return a;
  }

  static Future<bool> getPrices() async{
    DBConnection.prices.clear();
    bool a=await
    FirebaseFirestore.instance.collection('prices').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Price instance = Price.fromFirestore(docSnapshot);
          prices.add(instance);
        }
        return true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return a;
  }

  static Future<bool> getPromotions() async{
    DBConnection.promotions.clear();
    bool a= await
    FirebaseFirestore.instance.collection('promotions').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Promotion instance = Promotion.fromFirestore(docSnapshot);
          promotions.add(instance);
        }
        return true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return a;
  }

  static Future<void> getList(String doc,Function func) async{
    FirebaseFirestore.instance
        .collection('userShoppingList')
        .doc(doc)
        .get()
        .then(
      (querySnapshot) {
        var a = querySnapshot.data() as Map<String, dynamic>;
        var b = a['shoppingList'];
        ListContent.list.clear();
        for (String s in b.keys) {
          ListContent.list.addAll({DBConnection.productsSet[s]!: b[s]});
        }
        func();
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  static void updateFavorite() {  
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseStream.currentUser.getID())
        .update({'favoriteProducts': FirebaseStream.currentUser.favoriteProducts}).then(
            (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e")
        );
  }
}
