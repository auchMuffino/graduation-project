import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/FindInProducts.dart';
import '../Widgets/ProductsPlace.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          //Поиск,
          FindInProducts(),
          //Фильтрация,
          FilterProducts(),
          //Вывод продуктов,
          Expanded(
            child:ProductsPlace(),
          ),
        ],
        ),
      ) 
    );
  }
}