import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Pages/PromotionsPage.dart';
import 'package:flutter_project1/Tables/Promotion.dart';

import 'MainStructElement.dart';
import 'PromotionTile.dart';

class PromotionsGrid extends StatefulWidget {
  @override
  State<PromotionsGrid> createState() => _PromotionsGridState();
}

class _PromotionsGridState extends State<PromotionsGrid> {
  List<Promotion> promotionsList=List.empty(growable: true);

  void createChildren(){
    promotionsList.clear();
    for(Promotion promo in DBConnection.promotions){
      if(PromotionsPage.currentStore != null && promo.storeUNP != PromotionsPage.currentStore?.UNP){continue;}
      if(PromotionsPage.currentDate != null){
        if((promo.startDate.seconds - Timestamp.fromDate(PromotionsPage.currentDate!).seconds > 0)
            || (promo.endDate.seconds - Timestamp.fromDate(PromotionsPage.currentDate!).seconds < 0 )){continue;}
      }
      promotionsList.add(promo);
    }
    PromotionsPage.currentDate=null;
    promotionsList.sort(((b, a){
      if((a.startDate.seconds - Timestamp.now().seconds <= 0) && (a.endDate.seconds - Timestamp.now().seconds >= 0) && (b.startDate.seconds - Timestamp.now().seconds <= 0) && (b.endDate.seconds - Timestamp.now().seconds >= 0)){
        if(((a.endDate).toDate().difference((a.startDate).toDate())).inDays > ((b.endDate).toDate().difference((b.startDate).toDate())).inDays){
          return -1;
        } else if(((a.endDate).toDate().difference((a.startDate).toDate())).inDays < ((b.endDate).toDate().difference((b.startDate).toDate())).inDays){
          return 1;
        } else{
          return 0;
        }
      } else if((a.startDate.seconds - Timestamp.now().seconds <= 0) && (a.endDate.seconds - Timestamp.now().seconds >= 0) && !(b.startDate.seconds - Timestamp.now().seconds <= 0) || !(b.endDate.seconds - Timestamp.now().seconds >= 0)){
        return 1;
      } else if(!(a.startDate.seconds - Timestamp.now().seconds <= 0) || !(a.endDate.seconds - Timestamp.now().seconds >= 0) && (b.startDate.seconds - Timestamp.now().seconds <= 0) && (b.endDate.seconds - Timestamp.now().seconds >= 0)){
        return -1;
      } else{
        return 0;
      }
    }));
    //promotionsList.reversed;
  }

   Future<void> refresh() async{
    setState((){
      DBConnection.promotions.clear();
    });
    if(await Bones.init()){
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    createChildren();
    return Expanded(
      child: RefreshIndicator(
        color:  Color(0xFF4EC88C),
        onRefresh: refresh,
        child:DBConnection.promotions.isEmpty
        ? Center(child: CircularProgressIndicator(color: Color(0xFF4EC88C),),)
        : 
        ListView.builder(
          shrinkWrap: true,
          itemCount: promotionsList.length,
          itemBuilder: (BuildContext ctx, index) {
            return PromotionTile(
              currentPromo: promotionsList[index],
            );
          },
        ),
      ),
    );
  }
}