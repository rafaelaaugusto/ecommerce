import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';

final checkoutProvider = ChangeNotifierProvider<CheckoutProvider>(
  (ref) => CheckoutProvider(),
);

class CheckoutProvider extends ChangeNotifier {
  final List<ProductModel> products = [];

  int get productCount => products.length;

  void addProduct(ProductModel product) {
    removeProducts();

    products.add(product);
    notifyListeners();
  }

  void addProducts(List<ProductModel> productsSeletected) {
    removeProducts();
    products.addAll([...productsSeletected]);
    notifyListeners();
  }

  void removeProducts() {
    products.clear();
    notifyListeners();
  }
}
