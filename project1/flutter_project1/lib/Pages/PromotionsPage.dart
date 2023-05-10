
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Text(DBConnection.promotions.toString()),
          ),
        ),
      );
  }
}