import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/dialogs/remove_product_dialog.dart';
import '../components/product_image_component.dart';
import '../functions/helper_functions.dart';
import '../providers/shopping_cart_provider.dart';

class ShoppingCartView extends ConsumerStatefulWidget {
  const ShoppingCartView({super.key});

  @override
  ConsumerState<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends ConsumerState<ShoppingCartView> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = ref.watch(shoppingCartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(Insets.l * 2),
        itemCount: cartProvider.productCount,
        itemBuilder: (context, index) {
          final product = cartProvider.productList[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: Insets.xl,
              horizontal: Insets.m,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Insets.m),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            title: Text(
              product.name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Row(
              children: [
                Text(
                  UtilBrasilFields.obterReal(
                    double.parse(product.price),
                    moeda: true,
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: Insets.xl),
                ),
                const SizedBox(width: Insets.m),
                if (product.hasDiscount && product.discountValue.isNotBlank)
                  Badge(
                    backgroundColor: Colors.red.shade200,
                    label: Text(
                      getPercentualValue(product.discountValue!),
                    ),
                  ),
              ],
            ),
            leading: ProductImage(
              itemId: product.id,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.close,
              ),
              color: Colors.red,
              onPressed: () {
                showAdaptiveDialog(
                  context: context,
                  builder: (context) => RemoveProductDialog(
                    onPressed: () {
                      cartProvider.removeProduct(product);
                    },
                  ),
                );
              },
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/product-details',
                arguments: product,
              );
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: Insets.xl),
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
                cartProvider.totalValue,
                moeda: true,
              )}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
