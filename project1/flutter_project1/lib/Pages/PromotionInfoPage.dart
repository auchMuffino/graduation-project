import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Tables/Promotion.dart';
import 'package:google_fonts/google_fonts.dart';


class PromotionInfoPage extends StatelessWidget {

  Promotion promo;

  PromotionInfoPage({required this.promo});

  @override
  Widget build(BuildContext context) {
    Widget time;
    if((promo.startDate.seconds - Timestamp.now().seconds <=
            0) &&
        (promo.endDate.seconds - Timestamp.now().seconds >= 0)){
          time=Text( 'Осталось '+ ((promo.endDate).toDate().difference(DateTime.now())).inDays.toString() + 'дн',
                          style: GoogleFonts.comfortaa(
                                  color: Color(0xFF4EC88C),
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18));
        }else{
          time=Text( 'Акция неактивна',
                          style: GoogleFonts.comfortaa(
                                  color: Color(0xFFB96363),
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18));
        }
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(
          title: Text('Обратно к акциям',style: GoogleFonts.comfortaa(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            backgroundColor: Color(0xFF19280D)
        ),
        body:Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: Color(0xFFFDFDFD),
                child: Center(
                  child: Image.network(
                    promo.picturePath,
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
                      Text(promo.title,
                          style: GoogleFonts.comfortaa(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 24)),
                      Padding(padding: EdgeInsets.all(2)),
                      Padding(padding: EdgeInsets.only(top: 2, bottom: 5)),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color(0xFF19280D),
                          ),
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 3, bottom: 3),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(3),
                                    child: Text(
                                      promo.description,
                                      style: GoogleFonts.comfortaa(
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                               Padding(
                                      padding: EdgeInsets.only(top: 4, bottom: 4)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      'Место проведения: '+ DBConnection.stores[promo.storeUNP]!.title,
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.comfortaa(
                                          color: Colors.white54,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13)),
                                ],
                              ),
                               Padding(
                                      padding: EdgeInsets.only(top: 1, bottom: 1)),
                                      Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      'Скидка: '+ (promo.discount*100).toString() + '%',
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.comfortaa(
                                          color: Colors.white54,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13)),
                                ],
                              ),
                              Padding(
                                      padding: EdgeInsets.only(top: 1, bottom: 1)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  time
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 2, bottom: 5)),
                    ],
                  ),
                ),
              )
            ],
          ),
      )
    );
  }
}