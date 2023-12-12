import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Pages/ProductsPage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Tables/ChainStore.dart';

class DropDownProductStore extends StatefulWidget {
  final Function() func;
  DropDownProductStore({super.key, required this.func});
  @override
  State<DropDownProductStore> createState() => _DropDownProductStoreState();
}

class _DropDownProductStoreState extends State<DropDownProductStore> {
  // ChainStore? value=null;

  @override
  Widget build(BuildContext context) {
    List<ChainStore?> stor=List.empty(growable: true);
    stor.add(null);
    stor.addAll(List.from(DBConnection.stores.values));
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: const Color(0xFF19280D),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            spreadRadius: 4,
            blurRadius: 3,
            offset: Offset(0, 3),
          )
        ],
      ),
      height: 30,
      child: DropdownButton<ChainStore?>(
        underline: null,
        style: GoogleFonts.comfortaa(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 13),
        borderRadius:  BorderRadius.all(Radius.circular(5)),
        focusColor: Color(0xFF19280D),
        dropdownColor: Color(0xFF19280D),
        iconEnabledColor: Color(0xFF4EC88C),
        iconDisabledColor: Color(0xFF4EC88C),
        value: ProductsPage.currentStore,
        items: stor.map((ChainStore? store){
          String text;
          if(store == null){
            text='Выберите магазин';
          }else{
            text=store.title;
          } 
          return DropdownMenuItem<ChainStore?>(
            value: store,
            child: Text(text),
          );
        }).toList(),
        onChanged: (value){
        setState((){
          if(ProductsPage.currentStore != value){
            ProductsPage.currentStore=value;
            widget.func();
          }
        });},
      ),
    );
  }
}