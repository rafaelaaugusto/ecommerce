import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/product_image_component.dart';
import '../components/shopping_cart_icon_component.dart';
import '../functions/helper_functions.dart';
import '../models/product_model.dart';
import '../providers/checkout_provider.dart';
import '../providers/shopping_cart_provider.dart';
import '../providers/user_provider.dart';
import '../theme/styles_theme.dart';

class ProductDetailsView extends ConsumerStatefulWidget {
  const ProductDetailsView({super.key});

  @override
  ConsumerState<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends ConsumerState<ProductDetailsView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = ref.watch(shoppingCartProvider);
    final checkoutItensProvider = ref.watch(checkoutProvider);
    final currentUserProvider = ref.watch(userProvider);
    final ProductModel product =
        ModalRoute.of(context)?.settings.arguments as ProductModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Produto'),
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
      body: Padding(
        padding: const EdgeInsets.all(Insets.l * 2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(
                itemId: product.id,
                width: '400',
                heigth: '300',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.m),
                child: Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Row(
                children: [
                  Text(
                    UtilBrasilFields.obterReal(
                      double.parse(product.price),
                      moeda: true,
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
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
              if (product.description.isNotBlank)
                buildSection(
                  context: context,
                  title: 'Descrição',
                  text: product.description ?? '',
                ),
              if (product.department.isNotBlank)
                buildSection(
                  context: context,
                  title: 'Categoria',
                  text: product.department ?? '',
                ),
              if (product.material.isNotBlank)
                buildSection(
                  context: context,
                  title: 'Materiais',
                  text: product.material ?? '',
                ),
              if (product.details != null)
                buildSection(
                  context: context,
                  title: 'Detalhes',
                  text: product.details!.values.join(', '),
                ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: elevatedButtonOutlinedThemeData.style,
                onPressed: () {
                  if (!cartProvider.productList.contains(product)) {
                    cartProvider.addProduct(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Produto adicionado ao carrinho!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Esse produto já foi adicionado ao carrinho!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: const Icon(
                  Icons.add_shopping_cart,
                ),
              ),
            ),
            const SizedBox(width: Insets.m),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });

                  checkoutItensProvider.addProduct(product);
                  if (currentUserProvider.currentUser != null) {
                    Navigator.popAndPushNamed(context, '/checkout')
                        .then((value) => setState(
                              () {
                                isLoading = false;
                              },
                            ));
                  } else {
                    Navigator.pushNamed(
                      context,
                      '/register-user',
                    ).then(
                      (value) => setState(() {
                        isLoading = false;
                      }),
                    );
                  }
                },
                icon: isLoading
                    ? SizedBox(
                        height: Insets.l,
                        width: Insets.l,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onPrimary,
                          strokeWidth: Insets.xxs,
                        ),
                      )
                    : const SizedBox(),
                label: const Text('Comprar agora'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildSection({
  required BuildContext context,
  required String title,
  required String text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: Insets.l),
      Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      Text(
        text,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    ],
  );
}
