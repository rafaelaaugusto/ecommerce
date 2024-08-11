import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/product_selected_tem_component.dart';
import '../providers/checkout_provider.dart';

class CheckoutView extends ConsumerStatefulWidget {
  const CheckoutView({super.key});

  @override
  ConsumerState<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends ConsumerState<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    final checkoutItensProvider = ref.watch(checkoutProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(Insets.l * 2),
        itemCount: checkoutItensProvider.productCount,
        itemBuilder: (context, index) {
          final product = checkoutItensProvider.products[index];

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
