import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/dialogs/action_alert_dialog.dart';
import '../components/product_selected_tem_component.dart';
import '../providers/checkout_provider.dart';
import '../providers/shopping_cart_provider.dart';
import '../providers/user_provider.dart';

class ShoppingCartView extends ConsumerWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(shoppingCartProvider);
    final currentUserProvider = ref.watch(userProvider);
    final checkoutItensProvider = ref.watch(checkoutProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: cartProvider.productCount > 0
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.l * 2),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) => ActionAlertDialog(
                            title: 'Limpar carrinho',
                            subtitle:
                                'Tem certeza que deseja remover todos os itens do seu carrinho?',
                            onPressed: () {
                              cartProvider.removeAllProducts();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Limpar carrinho',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: Insets.xl,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
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
                    ),
                  ),
                  const SizedBox(height: Insets.l * 8),
                ],
              ),
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
                      checkoutItensProvider.addProducts(cartProvider.products);
                      if (currentUserProvider.currentUser != null) {
                        Navigator.pushNamed(
                          context,
                          '/checkout',
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
