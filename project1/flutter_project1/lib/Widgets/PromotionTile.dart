import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Tables/Promotion.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Pages/PromotionInfoPage.dart';

class PromotionTile extends StatefulWidget {
  late Promotion currentPromo;
  PromotionTile({super.key, required this.currentPromo});

  @override
  State<PromotionTile> createState() => _PromotionTileState();
}

class _PromotionTileState extends State<PromotionTile> {
  Widget? isActive = null;

  @override
  Widget build(BuildContext context) {
    if ((widget.currentPromo.startDate.seconds - Timestamp.now().seconds <=
            0) &&
        (widget.currentPromo.endDate.seconds - Timestamp.now().seconds >= 0)) {
      isActive = Container(
          decoration: const BoxDecoration(
            color: Color(0xFF4EC88C),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(7),
                bottomRight: Radius.circular(7),
                topLeft: Radius.circular(7),
                bottomLeft: Radius.circular(7)),
          ),
          padding: EdgeInsets.all(5),
          child: Text(
            'Активна',
            style: GoogleFonts.comfortaa(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ));
    } else {
      isActive = Container(
          decoration: const BoxDecoration(
            color: Color(0xFFB96363),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(7),
                bottomRight: Radius.circular(7),
                topLeft: Radius.circular(7),
                bottomLeft: Radius.circular(7)),
          ),
          padding: EdgeInsets.all(5),
          child: Text(
            'Неактивна',
            style: GoogleFonts.comfortaa(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ));
    }
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PromotionInfoPage(
            promo: widget.currentPromo,
          );
        }));
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: 80,
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
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
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: Image.network(
                    widget.currentPromo.picturePath,
                    height: 80,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Expanded(
                flex: 8,
                child: Column( 
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(widget.currentPromo.title,
                                style: GoogleFonts.comfortaa(
                                    color: Color(0xFF19280D),
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(bottom: 5, right: 6),
                              child: isActive!),
                        ],
                      )
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
    //
  }
}
