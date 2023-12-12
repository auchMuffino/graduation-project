import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Widgets/Buttons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Tables/Product.dart';

class ProductInfoPage extends StatelessWidget {
  Product selectedProduct;

  ProductInfoPage({required this.selectedProduct});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, true);
          return Future.value(false);
        },
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text('Обратно к товарам',
                style: GoogleFonts.comfortaa(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            backgroundColor: Color(0xFF19280D),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: Color(0xFFFDFDFD),
                child: Center(
                  child: Image.network(
                    selectedProduct.picturePath,
                    height: 110,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(2, 0),
                      )
                    ],
                    // border: Border(top: BorderSide(color: Color(0x2619280D))),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(selectedProduct.title,
                          style: GoogleFonts.comfortaa(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 24)),
                      Padding(padding: EdgeInsets.all(2)),
                      Text(
                          DBConnection
                              .categories[selectedProduct.category]!.title,
                          style: GoogleFonts.comfortaa(
                              color: Color(0xFF4EC88C),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 18)),
                      Padding(padding: EdgeInsets.only(top: 2, bottom: 5)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xFF19280D),
                        ),
                        padding: EdgeInsets.only(
                            left: 5, right: 5, top: 3, bottom: 3),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedProduct.description.substring(0, selectedProduct.description.length > 750? 750 : selectedProduct.description.length),
                              style: GoogleFonts.comfortaa(
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 4, bottom: 3)),
                            Text(
                                'Производитель: ' +
                                    selectedProduct.manufacturer,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.comfortaa(
                                    color: Colors.white54,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13)),
                            Padding(
                                padding: EdgeInsets.only(top: 1, bottom: 1)),
                            Text(
                                'Страна производства: ' +
                                    selectedProduct.countryOfOrigin,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.comfortaa(
                                    color: Colors.white54,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13)),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 2, bottom: 5)),
                      Buttons(
                        currentProduct: selectedProduct,
                        height: 40,
                        width: 150,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
