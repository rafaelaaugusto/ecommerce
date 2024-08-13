import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';

import '../functions/helper_functions.dart';
import '../models/product_model.dart';
import 'dialogs/action_alert_dialog.dart';
import 'product_image_component.dart';

class ProductSelectedItem extends StatelessWidget {
  final ProductModel product;
  final bool canRemoveItem;
  final Function(ProductModel)? removeItem;

  const ProductSelectedItem({
    super.key,
    required this.product,
    this.canRemoveItem = true,
    this.removeItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: Insets.m,
          horizontal: Insets.xl,
        ),
        title: Text(
          product.name,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Column(
          children: [
            Row(
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
            Text(
              product.description ?? '',
              style: Theme.of(context).textTheme.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        leading: ProductImage(
          itemId: product.id,
        ),
        trailing: canRemoveItem && removeItem != null
            ? IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 18,
                ),
                color: Colors.red,
                onPressed: () {
                  showAdaptiveDialog(
                    context: context,
                    builder: (context) => ActionAlertDialog(
                      title: 'Remover produto',
                      subtitle: 'Tem certeza que deseja remover este produto?',
                      onPressed: () {
                        removeItem?.call(product);
                      },
                    ),
                  );
                },
              )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Insets.m),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/product-details',
            arguments: product,
          );
        },
      ),
    );
  }
}
