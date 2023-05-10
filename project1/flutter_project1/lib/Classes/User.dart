import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'Product.dart';

class User{
  late String email;
  late String password;
  // var favoriteProducts=<Product>{};

  User({required this.email,required this.password});//,required this.favoriteProducts
  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return User(
      email: data?['email'],
      password: data?['password'],
      // favoriteProducts: data?['favoriteProducts'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (email != null) "email": email,
      if (password != null) "password": password,
      // if (favoriteProducts != null) "favoriteProducts": favoriteProducts,
    };
  }
  void setEmail(email){
    this.email=email;
  }
  void setPassword(password){
    this.password=password;
  }
}