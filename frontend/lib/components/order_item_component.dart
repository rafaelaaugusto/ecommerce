import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../models/order_model.dart';
import '../theme/colors_theme.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  const OrderItem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: Insets.m,
          horizontal: Insets.xl,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Insets.m),
        ),
        title: Text(
          'Pedido: #${order.idFormatted}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total: ${UtilBrasilFields.obterReal(
                double.parse(order.total),
                moeda: true,
              )}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Row(
              children: [
                Text(
                  '${order.products.length} itens',
                ),
                const Spacer(),
                Text(
                  order.createdAt!.format('dd/MM/yyyy'),
                ),
              ],
            ),
          ],
        ),
        leading: const Icon(
          FontAwesome.cube_solid,
          color: secondary,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: Insets.xxl,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/order-details',
            arguments: {'order': order},
          );
        },
      ),
    );
  }
}
