import 'package:cloud_firestore/cloud_firestore.dart';

class ChainStore{
  late String UNP;
  late String title;

  ChainStore({required this.UNP, required this.title});
  factory ChainStore.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    print("РУРУРУР");
    final data = snapshot.data();
    return ChainStore(
      UNP: data?['UNP'],
      title: data?['title'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (UNP != null) "UNP": UNP,
    };
  }
}