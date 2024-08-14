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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product-details',
          arguments: product,
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Insets.xl),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(
                heigth: '80',
                width: '80',
                itemId: product.id,
              ),
              const SizedBox(
                width: Insets.xl,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
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
                        if (product.hasDiscount &&
                            product.discountValue.isNotBlank)
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (canRemoveItem && removeItem != null) ...[
                const SizedBox(width: Insets.l),
                IconButton(
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
                        subtitle:
                            'Tem certeza que deseja remover este produto?',
                        onPressed: () {
                          removeItem?.call(product);
                        },
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
