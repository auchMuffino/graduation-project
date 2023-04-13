import 'package:flutter/material.dart';
import 'package:smart_catalog/Pages/ProductsPage.dart';

void main() {
  runApp(SmartCatalogMainStruct());
}

class SmartCatalogMainStruct extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductsPage(),
      
    );
  }
}