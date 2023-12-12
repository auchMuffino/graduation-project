import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Pages/ProductsPage.dart';

class FavoriteCheck extends StatefulWidget {
  final Function() func;
  FavoriteCheck({super.key,required this.func});

  @override
  State<FavoriteCheck> createState() => _FavoriteCheckState();
}

class _FavoriteCheckState extends State<FavoriteCheck> {

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.greenAccent;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: ProductsPage.favoriteCheck,
      onChanged: (bool? value) {
        setState(() {
          ProductsPage.favoriteCheck=value!;
          widget.func();
        });
      },
    );
  }
} 