import 'package:flutter_project1/Classes/Category.dart';
import 'package:flutter_project1/Classes/ChainStore.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Classes/Product.dart';

class Getter{
  static Product? getProductByID(String ID){
    for(Product instance in DBConnection.productsSet){
      if(instance.getID() == ID){
        return instance;
      }
    }
    return null;
  }
  static Category? getCategoryByID(String ID){
    for(Category instance in DBConnection.categories){
      if(instance.getID() == ID){
        return instance;
      }
    }
    return null;
  }
  static ChainStore? getStoreByUNP(String UNP){
    for(ChainStore instance in DBConnection.stores){
      if(instance.UNP == UNP){
        return instance;
      }
    }
    return null;
  }
}