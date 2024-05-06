import 'package:flutter/material.dart';
import 'package:flutter_project_store/model/product.dart';

class Shop extends ChangeNotifier {
  final List<Product> _product = [];

  List<Object> _cart = [];

  List<Product> get product => _product;
  List<Object> get cart => _cart;

  void addToCart(Object productItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(productItem);
    }
    notifyListeners();
  }

  void removeFromCart(Object productItem) {
    _cart.remove(productItem);
    notifyListeners();
  }

  void updateProducts(List<Product> newProducts) {
    _product.addAll(newProducts);
    notifyListeners();
  }
}
