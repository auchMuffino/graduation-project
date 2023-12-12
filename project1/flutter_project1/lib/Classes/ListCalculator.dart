import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Classes/ListContent.dart';

import '../Tables/ChainStore.dart';
import '../Tables/Price.dart';
import '../Tables/Promotion.dart';

class ListCalculator extends ChangeNotifier{
  static double totalCost=0;

  static Future<void> calc(ChainStore currentStore)async{
    ListCalculator.totalCost=0;
    ListContent.list.forEach((key, value) {
      for(Price price in DBConnection.prices){
        if(price.productID==key.getID() && price.storeUNP==currentStore.UNP){
          totalCost+=price.price*value;
          for(Promotion promo in DBConnection.promotions){
            if((promo.product == key.getID() || promo.category == key.category)
            && currentStore.UNP==promo.storeUNP
            && (promo.startDate.seconds - Timestamp.now().seconds <= 0)
            && (promo.endDate.seconds - Timestamp.now().seconds >= 0 )){
              totalCost -= (price.price * value * promo.discount);
            }
          }
        }
      }
    });
  }
  static List<Map> bestOffer(){ 
    double totalCostQ=0;
    ChainStore? currentStore;
    List<Map> offers=List.empty(growable: true);
    for(ChainStore store in DBConnection.stores.values){
        int productCount=0;
        totalCostQ=0;
        currentStore=store;
        ListContent.list.forEach((key, value) {
          for(Price price in DBConnection.prices){
          if(price.productID==key.getID() && price.storeUNP==store.UNP){
            productCount++;
            totalCostQ+=price.price*value;
            for(Promotion promo in DBConnection.promotions){
              if((promo.product == key.getID() || promo.category == key.category)
              && store.UNP==promo.storeUNP
              && (promo.startDate.seconds - Timestamp.now().seconds <= 0)
              && (promo.endDate.seconds - Timestamp.now().seconds >= 0 )){
                totalCostQ -= (price.price * value * promo.discount);
              }
            }
          }
        }
        if(productCount == ListContent.list.length)//Если цена не равна null
          offers.add({'currentStore' : currentStore, 'totalCost' : totalCostQ});
        });
      }
    offers.sort((a,b) => (a['totalCost']).compareTo(b['totalCost']));
    return offers;
  }
}