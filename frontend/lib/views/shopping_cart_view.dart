import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/shopping_cart_provider.dart';

class ShoppingCartView extends ConsumerStatefulWidget {
  const ShoppingCartView({super.key});

  @override
  ConsumerState<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends ConsumerState<ShoppingCartView> {
  @override
  Widget build(BuildContext context) {
    final shoppCart = ref.watch(shoppingCartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: ListView.builder(
        itemCount: shoppCart.productCount,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(shoppCart.productList[index].name),
          );
        },
      ),
    );
  }
}
