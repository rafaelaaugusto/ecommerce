import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/product_selected_tem_component.dart';
import '../providers/shopping_cart_provider.dart';
import '../providers/user_provider.dart';

class ShoppingCartView extends ConsumerWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(shoppingCartProvider);
    final currentUserProvider = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: cartProvider.productCount > 0
          ? ListView.separated(
              padding: const EdgeInsets.all(Insets.l * 2),
              itemCount: cartProvider.productCount,
              itemBuilder: (context, index) {
                final product = cartProvider.productList[index];
                return ProductSelectedItem(
                  product: product,
                  removeItem: cartProvider.removeProduct,
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: Insets.xl),
            )
          : _emptyData(context),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.l * 2,
          vertical: Insets.l,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ${UtilBrasilFields.obterReal(
                cartProvider.totalValue,
                moeda: true,
              )}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ElevatedButton(
              onPressed: cartProvider.productCount > 0
                  ? () {
                      if (currentUserProvider.currentUser != null) {
                        Navigator.popAndPushNamed(
                          context,
                          '/checkout',
                          arguments: cartProvider.productList,
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          '/register-user',
                        );
                      }
                    }
                  : null,
              child: const Text('Ir para pagamento'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyData(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_rounded,
            color: Theme.of(context).colorScheme.onSecondary,
            size: Insets.xxl * 2,
          ),
          const SizedBox(height: Insets.l),
          Text(
            'Carrinho vazio...',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
