import 'package:flutter/material.dart';
import '../Widgets/ProductsGrid.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  ProductsGrid()
      ),
    );
  }
}