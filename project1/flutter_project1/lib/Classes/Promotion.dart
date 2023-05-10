import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project1/Classes/Category.dart';
import 'package:flutter_project1/Classes/ChainStore.dart';
import 'package:flutter_project1/Classes/Product.dart';

import 'Getter.dart';

class Promotion{
  late String title;
  late String description;
  late String picturePath;
  late ChainStore storeUNP;
  late Timestamp startDate;
  late Timestamp endDate;
  late double discount;
  late Category? category;
  late Product? product;
  
  Promotion({required this.title, required this.description, required this.picturePath, required this.storeUNP, required this.startDate, required this.endDate, this.category,this.product,required this.discount});
  factory Promotion.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Promotion(
      title: data?['title'],
      description: data?['description'],
      picturePath: data?['imagePath'],
      storeUNP: Getter.getStoreByUNP(data?['storeUNP'])!,
      startDate: data?['startDate'],
      endDate: data?['endDate'],
      discount: data?['discount'],
      product: Getter.getProductByID(data?['category']),
      category: Getter.getCategoryByID(data?['category']),
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (picturePath != null) "imagePath": picturePath,
      if (storeUNP != null) "storeUNP": storeUNP.UNP,
      if (startDate != null) "startDate": startDate,
      if (endDate != null) "endDate": endDate,
      if (discount != null) "discount": discount,
      if (product != null) "product": product?.getID(),
      if (category != null) "category": category?.getID(),
    };
  }
}