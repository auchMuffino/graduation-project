import 'package:flutter/material.dart';
import '../Classes/DBConnection.dart';
import '../Widgets/ProductsGrid.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    DBConnection.getPromotions();
    DBConnection.getPrices();
    return Scaffold(
      body: SafeArea(
        child:  ProductsGrid()
      ),
    );
  }
}