import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../components/dialogs/action_alert_dialog.dart';
import '../components/order_details_component.dart';
import '../models/order_model.dart';
import '../providers/checkout_provider.dart';
import '../providers/shopping_cart_provider.dart';
import '../providers/user_provider.dart';
import '../services/order_service.dart';

class CheckoutView extends ConsumerStatefulWidget {
  const CheckoutView({super.key});

  @override
  ConsumerState<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends ConsumerState<CheckoutView> {
  OrderService orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    final checkout = ref.watch(checkoutProvider);
    final shoppingCart = ref.watch(shoppingCartProvider);
    final currentUser = ref.watch(userProvider).currentUser!;

    void onWillPop() {
      showAdaptiveDialog(
        context: context,
        builder: (context) => ActionAlertDialog(
          title: 'Sair do pagamento',
          subtitle:
              'Ao sair do pagamento seu pedido será perdido, deseja sair mesmo assim?',
          onPressed: () => Future.delayed(
            Duration.zero,
            () {
              checkout.removeProducts();
              Navigator.popAndPushNamed(context, '/');
            },
          ),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        onWillPop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pagamento'),
        ),
        body: OrderDetails(
          user: currentUser,
          products: checkout.products,
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.l * 2,
            vertical: Insets.l,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ${UtilBrasilFields.obterReal(
                  checkout.totalValue,
                  moeda: true,
                )}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  final order = OrderModel(
                    id: const Uuid().v4(),
                    products: checkout.products,
                    total: checkout.totalValue.toString(),
                    user: currentUser,
                  );
                  orderService.createOrder(order.toMap());

                  shoppingCart.removeProducts(checkout.products);

                  Navigator.popAndPushNamed(
                    context,
                    '/sucessful-purchase',
                    arguments: order,
                  );
                },
                child: const Text('Pagar agora'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
