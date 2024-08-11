import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';

import '../components/product_selected_tem_component.dart';
import '../models/product_model.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products =
        ModalRoute.of(context)?.settings.arguments as List<ProductModel>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(Insets.l * 2),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductSelectedItem(
            product: product,
            canRemoveItem: false,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: Insets.xl),
      ),
    );
  }
}
