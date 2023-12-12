import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Pages/ProductsPage.dart';
import 'package:flutter_project1/Tables/Category.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/DBConnection.dart';


class DropdownCategory extends StatefulWidget {
  final Function() func;
  DropdownCategory({super.key,required this.func});
  @override
  State<DropdownCategory> createState() => _DropdownCategoryState();
}

class _DropdownCategoryState extends State<DropdownCategory> {

  @override
  Widget build(BuildContext context) {
    List<Category?> cat=List.empty(growable: true);
    cat.add(null);
    cat.addAll(List.from(DBConnection.categories.values));
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: const Color(0xFF19280D),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            spreadRadius: 4,
            blurRadius: 3,
            offset: const Offset(0, 3),
          )
        ],
      ),
      height: 30,
      child: DropdownButton<Category?>(
        menuMaxHeight: 200,
        underline: null,
        style: GoogleFonts.comfortaa(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 13),
        borderRadius:  const BorderRadius.all(Radius.circular(5)),
          focusColor: const Color(0xFF19280D),
          dropdownColor: const Color(0xFF19280D),
          iconEnabledColor: const Color(0xFF4EC88C),
          iconDisabledColor: const Color(0xFF4EC88C),
        value: ProductsPage.currentCategory,
        items: cat.map((Category? category){
          String text;
          if(category==null){
            text='Выберите категорию';
          } else{
            text=category.title;
          }
          return DropdownMenuItem<Category?>(
            value: category,
            child: Text(text),
          );
        }).toList(),
        onChanged: (value){
        setState((){
          if(ProductsPage.currentCategory != value){
            ProductsPage.currentCategory=value;
            widget.func();
          }
        });
      }),
    );
  }
}