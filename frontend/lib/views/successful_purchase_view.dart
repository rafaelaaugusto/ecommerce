import 'package:flutter/material.dart';

import '../models/order_model.dart';

class SuccessfulPurchaseView extends StatelessWidget {
  const SuccessfulPurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderModel order =
        ModalRoute.of(context)?.settings.arguments as OrderModel;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Compra realizada com sucesso!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Icon(
                Icons.check_circle_outline,
                size: 120,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popAndPushNamed(
                  context,
                  '/order-details',
                  arguments: order,
                );
              },
              child: const Text('Detalhes do pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
