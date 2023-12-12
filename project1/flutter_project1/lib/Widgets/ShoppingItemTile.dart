import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/ListCalculator.dart';
import 'package:flutter_project1/Classes/ListContent.dart';
import 'package:flutter_project1/Pages/ShoppingListPage.dart';
import 'package:flutter_project1/Tables/Product.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/DBConnection.dart';
import '../Pages/ProductInfoPage.dart';
import '../Tables/Price.dart';

class ShoppingItemTile extends StatelessWidget {
  Product currentProduct;
  final Function() func;
  int count;
  ShoppingItemTile(
      {super.key,
      required this.currentProduct,
      required this.count,
      required this.func});
  @override
  Widget build(BuildContext context) {
    Color cl=Colors.white;
    if(ShoppingListPage.currentStore != null){
        bool inCurrentStore=false;
        for(Price pr in DBConnection.prices){
          if(currentProduct.getID() == pr.productID && pr.storeUNP == ShoppingListPage.currentStore?.UNP){
            inCurrentStore=true;
            break;
          }
        }
        if(!inCurrentStore){
          cl=Color.fromARGB(106, 255, 0, 0);
        }
    }
    Icon currentSubstract;
    if (count > 1) {
      currentSubstract = const Icon(
        Icons.remove_circle,
        color: Color(0xFF4EC88C),
      );
    } else {
      currentSubstract = const Icon(
        Icons.remove_circle_outline,
        color: Color(0xFF4EC88C),
      );
    }
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductInfoPage(
              selectedProduct: currentProduct,
            );
          }));
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
            color: cl,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                spreadRadius: 1.5,
                blurRadius: 4,
                offset: Offset(0, 3),
              )
            ],
          ),
            child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25), bottomRight: Radius.circular(25), topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(2, 0),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25), topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    child: Image.network(
                          currentProduct.picturePath,
                          height: 60,
                      ),
                  ),
                ),
              ),
              Text(currentProduct.title.length>11 ? currentProduct.title.substring(0, 11)+'...'
            :   currentProduct.title,
              style: GoogleFonts.comfortaa(
                color: Color(0xFF19280D),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 14)
                ),
              IconButton(
                  onPressed: () {
                    if (count > 1) {
                      count--;
                      ListContent.subtract(currentProduct);
                      func();
                    }
                  },
                  icon: currentSubstract),
              Text(count.toString(),
               style: GoogleFonts.comfortaa(
                color: Color(0xFF19280D),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 16)
              ),
              IconButton(
                  onPressed: () {
                    count++;
                    ListContent.add(currentProduct);
                    func();
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    color: const Color(0xFF4EC88C),
                  )),
              IconButton(
                  onPressed: () async{
                    ListContent.removeFromList(currentProduct, func);
                    ListCalculator.totalCost = 0;
                    if (ShoppingListPage.currentStore != null) {
                      await ListCalculator.calc(ShoppingListPage.currentStore!);
                    } else {
                      if (ListContent.list.isNotEmpty) {
                        final offer = await ListCalculator.bestOffer();
                        if (offer.first['totalCost'] != null) {
                          ListCalculator.totalCost = offer.first['totalCost'];
                        } else {
                          ListCalculator.totalCost = 0;
                        }
                      }
                    }
                    func();
                  },
                  icon: Icon(Icons.delete))
            ]),
          ),
        ));
  }
}
