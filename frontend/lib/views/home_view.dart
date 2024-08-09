import 'package:flutter/material.dart';

import '../components/products_list_component.dart';
import '../components/search_filter_component.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ProductService apiService = ProductService();
  List<ProductModel> products = [];
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchProductsData();
  }

  Future<void> fetchProductsData() async {
    try {
      products = await apiService.fetchProducts();
    } catch (e) {
      hasError = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasError
          ? const Center(child: Text('Erro ao carregar ativos.'))
          : products.isNotEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      SearchFilter(),
                      ProductsList(
                        products: products,
                      )
                    ],
                  ),
                )
              : Center(child: const CircularProgressIndicator()),
    );
  }
}
