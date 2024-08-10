import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/theme/styles_theme.dart';

import '../components/product_image_component.dart';
import '../functions/helper_functions.dart';
import '../models/product_model.dart';
import '../providers/shopping_cart_provider.dart';

class ProductDetailsView extends ConsumerWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(shoppingCartProvider);
    final ProductModel product =
        ModalRoute.of(context)?.settings.arguments as ProductModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Produto'),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(Insets.xxl * 2),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/shopping-cart',
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.xxl),
              child: Icon(Icons.shopping_cart),
            ),
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
                  cartProvider.addProduct(product);
                },
                child: const Icon(
                  Icons.add_shopping_cart,
                ),
              ),
            ),
            const SizedBox(width: Insets.m),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  cartProvider.addProduct(product);
                },
                child: const Text('Comprar agora'),
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
