
import '../Tables/Product.dart';

class ListContent{
  static var list=<Product,int>{};

  static void addToList(product,count){
    list.addAll({product:count});
  }
  static void changeCount(product, count){
    list.update(product, (value) => count);
  }
  static void add(product){
    list.update(product, (value) => list[product]! + 1);
    ;
  }
  static void removeFromList(product, Function func){
    list.remove(product);
    func();
  }
  static void subtract(product){
    list.update(product, (value) => list[product]! - 1);
  }
  static  Map<String,int?> newList(){
    Map<String,int?> newList={};
    for(Product product in list.keys){
      newList.addAll({product.getID() : list[product]});
    }
    return newList;
  }
}