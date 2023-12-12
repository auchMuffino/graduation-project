import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/Classes/ListContent.dart';

class OuterActions {
  static void shareList(context) {
    FirebaseFirestore.instance
        .collection('userShoppingList')
        .add({'shoppingList': ListContent.newList()}).then((value) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Ваш код'),
          content: InkWell(
            onTap: (){
              String s=value.id;
              Clipboard.setData(ClipboardData(text: s));
            },
            child: Text(value.id)
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK',style: TextStyle(color: Color(0xFF4EC88C)),),
            ),
          ],
        ),
      );
    });
  }
}
