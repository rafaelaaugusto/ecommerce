import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../models/product_model.dart';
import '../models/user_model.dart';
import 'product_selected_item_component.dart';

class OrderDetails extends StatelessWidget {
  final UserModel user;
  final List<ProductModel> products;
  final String? orderId;
  final DateTime? createdAt;

  const OrderDetails({
    super.key,
    required this.user,
    required this.products,
    this.orderId,
    this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.l * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (orderId.isNotBlank) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.xl),
              child: Text(
                'Pedido #$orderId',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: Insets.m,
                horizontal: Insets.xl,
              ),
              leading: Icon(
                FontAwesome.map_location_solid,
                color: Theme.of(context).colorScheme.secondary,
              ),
              titleTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: Insets.xl,
                  ),
              subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
              title: Wrap(
                spacing: Insets.m,
                children: [
                  Text(user.name),
                  if (user.phone.isNotBlank) Text('Celular: ${user.phone!}'),
                  Text('Email: ${user.email}'),
                ],
              ),
              subtitle: Wrap(
                spacing: Insets.s,
                children: [
                  Text('Endereço: ${user.adress.street}'),
                  Text(user.adress.city),
                  Text(user.adress.state),
                  Text(user.adress.zipcode),
                  if (user.adress.extra.isNotBlank) Text(user.adress.extra!)
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Insets.m),
              ),
            ),
          ),
          const SizedBox(height: Insets.xl),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${products.length} itens',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              if (createdAt != null)
                Text(
                  createdAt!.format('dd/MM/yyyy'),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
            ],
          ),
          const SizedBox(height: Insets.l),
          Expanded(
            child: ListView.separated(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductSelectedItem(
                  product: product,
                  canRemoveItem: false,
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: Insets.xl),
            ),
          ),
          const SizedBox(height: Insets.l * 7),
        ],
      ),
    );
  }
}
