import 'package:flutter/material.dart';

class SuccessfulPurchaseView extends StatelessWidget {
  const SuccessfulPurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
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
                Navigator.popAndPushNamed(context, '/order-details');
              },
              child: const Text('Detalhes do pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
