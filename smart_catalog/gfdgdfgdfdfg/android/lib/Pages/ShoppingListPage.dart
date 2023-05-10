
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/ListContent.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Center(
          child: Column(
            children: [
              Text(ListContent.list.toString()),
            ],
          ),
        ),
      ),
    );
  }
}