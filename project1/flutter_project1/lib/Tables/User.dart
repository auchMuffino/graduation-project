import 'package:cloud_firestore/cloud_firestore.dart';

class UserCatalog{
  late String _ID='';
  late String email;
  List<dynamic> favoriteProducts=[];

  UserCatalog({required this.email,required this.favoriteProducts});
  factory UserCatalog.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    List<dynamic> favProduct;
    if(data?['favoriteProducts']==null){
      favProduct=[];
    } else{
      favProduct=data?['favoriteProducts'];
    }
    return UserCatalog(
      email: data?['email'],
      favoriteProducts: favProduct
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (email != null) "email": email,
      if (favoriteProducts != null) "favoriteProducts": favoriteProducts,
    };
  }
  void setID(String ID){
    this._ID=ID;
  }
  String getID(){
    return this._ID;
  }
}