import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project1/Classes/Categories.dart';

class Product{
  late String _ID;
  late String picturePath;
  late String title;
  // late Category category;
  late String description;
  late String manufacturer;
  late String countryOfOrigin;

  Product({required this.title, required this.description,required this.manufacturer, required this.countryOfOrigin,required this.picturePath});
  void setID(String _ID){
    this._ID=_ID;
  }
  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Product(
      title: data?['title'],
      description: data?['description'],
      manufacturer: data?['manufacturer'],
      countryOfOrigin: data?['countryOfOrigin'],
      picturePath: data?['imagePath'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (manufacturer != null) "manufacturer": manufacturer,
      if (countryOfOrigin != null) "countryOfOrigin": countryOfOrigin,
      if (picturePath != null) "imagePath": picturePath,
    };
  }
}