import 'package:cloud_firestore/cloud_firestore.dart';

class Category{
  late String _ID;
  late String title;

  Category({required this.title});
  factory Category.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Category(
      title: data?['title'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
    };
  }
  void setID(String ID){
    this._ID=ID;
  }
  String getID(){
    return this._ID;
  }
}