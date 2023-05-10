import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/Product.dart';

class AddedCount extends ChangeNotifier{
  late Product product;
  int _count=0;
  
  AddedCount({required this.product});

  int getCount(){
    return _count;
  }
  void add(){
    _count++;
    notifyListeners();
  }
  void subtract(){
    _count--;

    notifyListeners();
  }
  void setCount(count){
    this._count=count;

    notifyListeners();
  }
}