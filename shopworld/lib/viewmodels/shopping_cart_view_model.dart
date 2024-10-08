import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';

final shoppingCartProvider = ChangeNotifierProvider<ShoppingCartProvider>(
  (ref) => ShoppingCartProvider(),
);

class ShoppingCartProvider extends ChangeNotifier {
  final List<ProductModel> products = [];

  int get productCount => products.length;
  double get totalValue => products.fold(
      0, (previousValue, prod) => double.parse(prod.price) + previousValue);

  void addProduct(ProductModel product) {
    products.add(product);
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    products.remove(product);
    notifyListeners();
  }

  void removeProducts(List<ProductModel> productsToRemove) {
    for (var product in productsToRemove) {
      products.remove(product);
    }
    notifyListeners();
  }

  void removeAllProducts() {
    products.clear();
    notifyListeners();
  }
}
