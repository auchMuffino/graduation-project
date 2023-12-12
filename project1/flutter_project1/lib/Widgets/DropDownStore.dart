import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Pages/PromotionsPage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Tables/ChainStore.dart';

class DropDownStore extends StatefulWidget {
  final Function() func;
  DropDownStore({super.key, required this.func});
  @override
  State<DropDownStore> createState() => _DropDownStoreState();
}

class _DropDownStoreState extends State<DropDownStore> {
  //ChainStore? value=null;

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
        value: PromotionsPage.currentStore,
        items: stor.map((ChainStore? store){
          String text;
          if(store == null){
            text='Выберите магазин';
          }else{
            text=store.title;
          } 
          return new DropdownMenuItem<ChainStore?>(
            value: store,
            child: Text(text),
          );
        }).toList(),
        onChanged: (value){
        setState((){
          if(PromotionsPage.currentStore != value){
           PromotionsPage.currentStore=value;
            //PromotionsPage.currentStore=value?.UNP;
            widget.func();
          }
        });},
      ),
    );
  }
}