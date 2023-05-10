import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/Products.dart';

class ProductInfoPage extends StatelessWidget {

  // late String productID; 
  Product selectedProduct;

  ProductInfoPage({required this.selectedProduct});

  // ProductInfoPage({required this.productID});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Center(child: Text("ПРОДУКТ ИНФО"),)
    );
  }
}