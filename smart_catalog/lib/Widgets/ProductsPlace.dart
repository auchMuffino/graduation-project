import 'package:flutter/cupertino.dart';

class ProductsPlace extends StatelessWidget {
  ProductsPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      crossAxisCount: 2,
      children: [],
    );
  }
}