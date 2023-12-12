import 'package:cloud_firestore/cloud_firestore.dart';

class Promotion{
  late String title;
  late String description;
  late String picturePath;
  late String storeUNP;
  late Timestamp startDate;
  late Timestamp endDate;
  late double discount;
  late String? category;
  late String? product;
  
  Promotion({required this.title, required this.description, required this.picturePath, required this.storeUNP, required this.startDate, required this.endDate, this.category,this.product,required this.discount});
  factory Promotion.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Promotion(
      title: data?['title'],
      description: data?['description'],
      picturePath: data?['imagePath'],
      storeUNP: data?['storeUNP'],
      startDate: data?['startDate'],
      endDate: data?['endDate'],
      discount: data?['discount'],
      product: data?['product'],
      category: data?['category'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (picturePath != null) "imagePath": picturePath,
      if (storeUNP != null) "storeUNP": storeUNP,
      if (startDate != null) "startDate": startDate,
      if (endDate != null) "endDate": endDate,
      if (discount != null) "discount": discount,
      if (product != null) "product": product,
      if (category != null) "category": category,
    };
  }
}