import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Pages/ProductsPage.dart';

class ActivePromoCheck extends StatefulWidget {
  final Function() func;
  ActivePromoCheck({super.key,required this.func});

  @override
  State<ActivePromoCheck> createState() => _ActivePromoCheckState();
}

class _ActivePromoCheckState extends State<ActivePromoCheck> {

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
      return Color(0xFF4EC88C);
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: ProductsPage.activePromo,
      onChanged: (bool? value) {
        setState(() {
          ProductsPage.activePromo=value!;
          widget.func();
        });
      },
    );
  }
} 