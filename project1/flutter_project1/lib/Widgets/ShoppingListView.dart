import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/ListContent.dart';
import 'package:flutter_project1/Widgets/ShoppingItemTile.dart';

class ShoppingListView extends StatelessWidget{
  final Function() func;
  ShoppingListView({required this.func});
  List<Map> shoppingList=List.empty(growable: true);
  void refresh(){
    func();
  }

  void createChildren(){
    shoppingList.clear();
    ListContent.list.forEach((key, value) {
      shoppingList.add({
          'currentProduct' : key, 
          'count': value, 
          'func': refresh
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    createChildren();
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 10),
        itemCount: shoppingList.length,
        itemBuilder: (BuildContext ctx, index) {
          return ShoppingItemTile(
            currentProduct: shoppingList[index]['currentProduct'],
            count: shoppingList[index]['count'],
            func: shoppingList[index]['func'],
          );
        },
      ),
    );
  }
}