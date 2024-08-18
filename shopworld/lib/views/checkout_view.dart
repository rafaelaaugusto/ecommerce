import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../components/dialogs/action_alert_dialog.dart';
import '../components/order_details_component.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';
import '../viewmodels/checkout_view_model.dart';
import '../viewmodels/shopping_cart_view_model.dart';
import '../viewmodels/user_view_model.dart';

class CheckoutView extends ConsumerStatefulWidget {
  const CheckoutView({super.key});

  @override
  ConsumerState<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends ConsumerState<CheckoutView> {
  OrderService orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = ref.watch(checkoutProvider);
    final cartViewModel = ref.watch(shoppingCartProvider);
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
              checkoutViewModel.removeProducts();
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
          products: checkoutViewModel.products,
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
                  checkoutViewModel.totalValue,
                  moeda: true,
                )}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  final order = OrderModel(
                    id: const Uuid().v4(),
                    products: checkoutViewModel.products,
                    total: checkoutViewModel.totalValue.toString(),
                    user: currentUser,
                  );
                  orderService.createOrder(order.toMap());
                  cartViewModel.removeProducts(checkoutViewModel.products);

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
