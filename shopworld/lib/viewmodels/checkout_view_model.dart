import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/product_model.dart';

final checkoutProvider = ChangeNotifierProvider<CheckoutViewModel>(
  (ref) => CheckoutViewModel(),
);

class CheckoutViewModel extends ChangeNotifier {
  final List<ProductModel> products = [];

  String get getId => const Uuid().v4();
  int get productCount => products.length;
  double get totalValue => products.fold(
      0, (previousValue, prod) => double.parse(prod.price) + previousValue);

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
