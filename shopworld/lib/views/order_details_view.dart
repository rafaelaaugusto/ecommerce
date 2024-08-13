import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';

import '../components/order_details_component.dart';
import '../models/order_model.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> params =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final order = params['order'] as OrderModel;
    final isFromShoppingCart = params['isFromShoppingCart'] as bool? ?? false;

    void onWillPop() {
      if (isFromShoppingCart) {
        Navigator.popAndPushNamed(context, '/');
      } else {
        Navigator.pop(context);
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        onWillPop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes da compra'),
        ),
        body: OrderDetails(
          orderId: order.idFormatted,
          user: order.user,
          products: order.products,
          createdAt: order.createdAt,
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(
            bottom: Insets.xxl,
            left: Insets.l * 2,
            right: Insets.l * 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total: ${UtilBrasilFields.obterReal(
                  double.parse(order.total),
                  moeda: true,
                )}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
