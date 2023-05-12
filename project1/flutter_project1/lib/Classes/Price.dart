import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project1/Classes/ChainStore.dart';
import 'package:flutter_project1/Classes/Getter.dart';
import 'package:flutter_project1/Classes/Product.dart';

class Price{
  late ChainStore storeUNP;
  late Product productID;
  late double price;

  Price({required this.productID, required this.storeUNP, required this.price});
  factory Price.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Price(
      storeUNP: Getter.getStoreByUNP(data?['storeUNP'])!,
      productID: Getter.getProductByID(data?['productID'])!,
      price: data?['price'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (storeUNP != null) "storeUNP": storeUNP.UNP,
      if (productID != null) "productID": productID.getID(),
      if (price != null) "price": price,
    };
  } 
}