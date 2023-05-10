import 'Product.dart';

class ListContent{
  static var list=<Product,int>{};

  static void addToList(product,count){
    list.addAll({product:count});
  }
  static void changeCount(product, count){
    list.update(product, (value) => count);
  }
  static void removeFromList(product){
    list.remove(product);
  }
}