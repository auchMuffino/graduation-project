import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/Product.dart';
import 'package:flutter_project1/Widgets/Buttons.dart';

class ProductInfoPage extends StatelessWidget {

  Product selectedProduct;

  ProductInfoPage({required this.selectedProduct});

  // ProductInfoPage({required this.productID});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(
          title: Text(selectedProduct.title)
        ),
        body: Column(
          children: [
            // Image.network(
            //     selectedProduct.picturePath,
            //     height: 110,
            // ),
            // const Padding(
            //   padding: EdgeInsets.all(20)
            // ),
            // Text(selectedProduct.title),
            // Text(selectedProduct.description),
            // Text(selectedProduct.manufacturer),
            // Text(selectedProduct.countryOfOrigin),
            Buttons(),
          ],
          ),
      )
    );
  }
}