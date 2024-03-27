import 'package:flutter/cupertino.dart';

class ProductsCountProvider with ChangeNotifier{
  int _productsCount = 1;

  //getters
  int get getProductsCount => _productsCount;

  //setters
  set setProductsCount(int val){
    _productsCount = val;
    notifyListeners();
  }

  //functions
  resetProductsCount(){
    _productsCount = 1;
    notifyListeners();
  }
}