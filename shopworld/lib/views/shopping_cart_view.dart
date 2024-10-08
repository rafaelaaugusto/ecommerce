import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/dialogs/action_alert_dialog.dart';
import '../components/empty_data_component.dart';
import '../components/layout_box_component.dart';
import '../components/product_selected_item_component.dart';
import '../viewmodels/checkout_view_model.dart';
import '../viewmodels/shopping_cart_view_model.dart';
import '../viewmodels/user_view_model.dart';

class ShoppingCartView extends ConsumerWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartViewModel = ref.watch(shoppingCartProvider);
    final userViewModel = ref.watch(userProvider);
    final checkoutViewModel = ref.watch(checkoutProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: cartViewModel.products.isNotBlank
          ? LayoutBox(
              child: Padding(
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
                                cartViewModel.removeAllProducts();
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
                        itemCount: cartViewModel.productCount,
                        itemBuilder: (context, index) {
                          final product = cartViewModel.products[index];
                          return ProductSelectedItem(
                            product: product,
                            removeItem: cartViewModel.removeProduct,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: Insets.xl),
                      ),
                    ),
                    const SizedBox(height: Insets.l * 8),
                  ],
                ),
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
                cartViewModel.totalValue,
                moeda: true,
              )}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ElevatedButton(
              onPressed: cartViewModel.productCount > 0
                  ? () {
                      checkoutViewModel.addProducts(cartViewModel.products);
                      if (userViewModel.currentUser != null) {
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
