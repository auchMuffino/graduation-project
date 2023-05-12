import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/ListContent.dart';
import 'package:provider/provider.dart';

import '../Classes/ProductCount.dart';
import '../Classes/Product.dart';
import 'Buttons.dart';

class ProductCard extends StatefulWidget {
  late Product curentProduct;

  ProductCard({super.key, required this.curentProduct});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddedCount>(
      create: (context) => AddedCount(product: this.widget.curentProduct),
      child: Container(
          color: Colors.grey,
          width: 100,
          height: 100,
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Image.network(
              widget.curentProduct.picturePath,
              height: 40,
            ),
            Text(widget.curentProduct.title),
            Text(widget.curentProduct.category.title),
            Buttons(),
          ]),
        ),
      );
  }
}
