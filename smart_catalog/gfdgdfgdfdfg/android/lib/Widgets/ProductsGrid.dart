import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Classes/Products.dart';
import 'package:flutter_project1/Pages/ProductsPage.dart';
import 'package:flutter_project1/Widgets/ProductCard.dart';

import '../Pages/ProductInfoPage.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({super.key});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {

  var productsSet=<Widget>[];

  void createChildren(){
    for(Product instance in DBConnection.productsSet){
      productsSet.add(
        InkWell(
          child: ProductCard(curentProduct: instance),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              // return ProductInfoPage(productID: ProductCard.productID);
              return ProductInfoPage(selectedProduct: instance,);
            }));
          },
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    createChildren();
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: productsSet,

    );
  }
}
