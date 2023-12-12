import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/firebase_streem.dart';
import '../Pages/ProductInfoPage.dart';
import '../Tables/Product.dart';
import 'Buttons.dart';

class ProductCard extends StatefulWidget {
  late Product currentProduct;
  ProductCard({super.key, required this.currentProduct});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Icon currentIconFav = const Icon(
    Icons.star_border,
    color: Color(0xFF4EC88C),
    size: 20.0,
    semanticLabel: 'Добавить в избранное',
  );
  bool isFavorite = false;
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseStream.currentUser.favoriteProducts
        .contains(widget.currentProduct.getID())) {
      currentIconFav = const Icon(
        Icons.star,
        color: Color(0xFF4EC88C),
        size: 24.0,
        semanticLabel: 'Убрать из избранного',
      );
    } else {
      currentIconFav = const Icon(
        Icons.star_border,
        color: Colors.greenAccent,
        size: 24.0,
        semanticLabel: 'Добавить в избранное',
      );
    }
    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ProductInfoPage(
              selectedProduct: widget.currentProduct,
            );
          }),
        );
        if (result != null) {
          setState(() {});
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              spreadRadius: 1.5,
              blurRadius: 4,
              offset: Offset(0, 3),
            )
          ],
        ),
        width: 140,
        height: 140,
        child: Column(children: [
          Stack(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      spreadRadius: 1.5,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                width: 200,
                height: 80,
              ),
              Center(
                child: Image.network(
                  widget.currentProduct.picturePath,
                  width: 138,
                  height: 79.18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.2),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: Center(child: currentIconFav),
                    ),
                    onTap: () {
                      if (!FirebaseStream.currentUser.favoriteProducts
                          .contains(widget.currentProduct.getID())) {
                        FirebaseStream.currentUser.favoriteProducts
                            .add(widget.currentProduct.getID());
                        DBConnection.updateFavorite();
                      } else {
                        FirebaseStream.currentUser.favoriteProducts
                            .remove(widget.currentProduct.getID());
                        DBConnection.updateFavorite();
                      }
                      setState(() {});
                    }),
              )
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
          Text(
            widget.currentProduct.title.length>15 ? widget.currentProduct.title.substring(0, 15)+'...'
            : widget.currentProduct.title,
            style: GoogleFonts.comfortaa(
                color: Color(0xFF19280D),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
          Text(
            DBConnection.categories[widget.currentProduct.category]!.title,
            style: GoogleFonts.comfortaa(
                color: Color(0xFF19280D),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 12),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
          Buttons(currentProduct: widget.currentProduct,height: 35,width: 110,),
        ]),
      ),
    );
  }
}
