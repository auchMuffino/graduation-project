import 'package:flutter/material.dart';
import 'package:flutter_project1/Widgets/ProductCard.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({super.key});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
      ],
    );
  }
}