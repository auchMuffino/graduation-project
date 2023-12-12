import 'package:cloud_firestore/cloud_firestore.dart';

class Price{
  late String storeUNP;
  late String productID;
  late double price;

  Price({required this.productID, required this.storeUNP, required this.price});
  factory Price.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Price(
      storeUNP: data?['storeUNP'],
      productID: data?['productID'],
      price: data?['price'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (storeUNP != null) "storeUNP": storeUNP,
      if (productID != null) "productID": productID,
      if (price != null) "price": price,
    };
  } 
}