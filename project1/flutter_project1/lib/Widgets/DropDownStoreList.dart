import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/ListCalculator.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Pages/ShoppingListPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Tables/ChainStore.dart';

class DropDownStoreList extends StatefulWidget {
  Function func;
  DropDownStoreList({super.key, required this.func});
  @override
  State<DropDownStoreList> createState() => _DropDownStoreListState();
}

class _DropDownStoreListState extends State<DropDownStoreList> {
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
            offset: const Offset(0, 3),
          )
        ],
      ),
      height: 30,
      child: DropdownButton<ChainStore?>(
        style: GoogleFonts.comfortaa(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 14),
        borderRadius:  const BorderRadius.all(Radius.circular(5)),
          focusColor: const Color(0xFF19280D),
          dropdownColor: const Color(0xFF19280D),
          iconEnabledColor: const Color(0xFF4EC88C),
          iconDisabledColor: const Color(0xFF4EC88C), 
        value: ShoppingListPage.currentStore,
        items: stor.map((ChainStore? store){
          String text;
          if(store == null){
            text='Выберите магазин';
          }else{
            text=store.title;
          } 
          return  DropdownMenuItem<ChainStore?>(
            value: store,
            child: Text(text),
          );
        }).toList(),
        onChanged: (value){
        setState((){
          if(ShoppingListPage.currentStore != value){
            ShoppingListPage.currentStore=value;
            if(ShoppingListPage.currentStore != null){
              ListCalculator.totalCost=0;
              ListCalculator.calc(value!);
              
            }
            widget.func();
          }
        });},
      ),
    );
  }
}