import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/dialogs/action_alert_dialog.dart';
import '../components/empty_data_component.dart';
import '../components/product_selected_item_component.dart';
import '../providers/checkout_provider.dart';
import '../providers/shopping_cart_provider.dart';
import '../providers/user_provider.dart';

class ShoppingCartView extends ConsumerWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingCart = ref.watch(shoppingCartProvider);
    final currentUserProvider = ref.watch(userProvider);
    final checkout = ref.watch(checkoutProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: shoppingCart.products.isNotBlank
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
                              shoppingCart.removeAllProducts();
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
                      itemCount: shoppingCart.productCount,
                      itemBuilder: (context, index) {
                        final product = shoppingCart.products[index];
                        return ProductSelectedItem(
                          product: product,
                          removeItem: shoppingCart.removeProduct,
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
          : const EmptyData(
              text: 'Carrinho vazio...',
            ),
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
                shoppingCart.totalValue,
                moeda: true,
              )}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ElevatedButton(
              onPressed: shoppingCart.productCount > 0
                  ? () {
                      checkout.addProducts(shoppingCart.products);
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
}
