import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/products_list_component.dart';
import '../components/search_filter_component.dart';
import '../components/shopping_cart_icon_component.dart';
import '../models/product_model.dart';
import '../providers/shopping_cart_provider.dart';
import '../services/product_service.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  ProductService apiService = ProductService();
  List<ProductModel> allProducts = [];
  List<ProductModel> products = [];
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchProductsData();
  }

  Future<void> fetchProductsData() async {
    try {
      allProducts = await apiService.fetchProducts();
      products = allProducts;
    } catch (e) {
      hasError = true;
    }
    setState(() {});
  }

  void filterByText(String term) {
    final productsFiltered = allProducts
        .where(
          (element) => element.name.toLowerCase().contains(
                term.trim().toLowerCase(),
              ),
        )
        .toList();

    products = productsFiltered;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = ref.watch(shoppingCartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopWorld'),
        actions: [
          ShoppingCartIcon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/shopping-cart',
              );
            },
            productCount: cartProvider.productCount,
          ),
        ],
      ),
      body: hasError
          ? const Center(
              child: Text('Erro ao carregar produtos.'),
            )
          : allProducts.isNotBlank
              ? Padding(
                  padding: const EdgeInsets.all(Insets.l * 2),
                  child: Column(
                    children: [
                      SearchFilter(
                        filterByText: filterByText,
                      ),
                      ProductsList(products: products),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}
