import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../models/order_model.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  const OrderItem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: Insets.m,
        horizontal: Insets.xl,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Insets.m),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
      title: Text(
        order.id,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        UtilBrasilFields.obterReal(
          double.parse(order.total),
          moeda: true,
        ),
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontSize: Insets.xl),
      ),
      leading: const Icon(AntDesign.codepen_outline),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/order-details',
          arguments: order,
        );
      },
    );
  }
}
