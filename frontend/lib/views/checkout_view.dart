import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:uuid/uuid.dart';

import '../components/dialogs/action_alert_dialog.dart';
import '../components/product_selected_tem_component.dart';
import '../models/order_model.dart';
import '../providers/checkout_provider.dart';
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
    final checkoutItensProvider = ref.watch(checkoutProvider);
    final user = ref.watch(userProvider).currentUser!;

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
              checkoutItensProvider.removeProducts();
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Insets.l * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: Insets.m,
                    horizontal: Insets.xl,
                  ),
                  leading: Icon(
                    FontAwesome.map_location_solid,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  titleTextStyle:
                      Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: Insets.xl,
                          ),
                  subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                  title: Wrap(
                    spacing: Insets.m,
                    children: [
                      Text(user.name),
                      if (user.phone.isNotBlank)
                        Text('Celular: ${user.phone!}'),
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
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: Insets.xl),
                const Divider(),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: Insets.l),
                  itemCount: checkoutItensProvider.productCount,
                  itemBuilder: (context, index) {
                    final product = checkoutItensProvider.products[index];

                    return ProductSelectedItem(
                      product: product,
                      canRemoveItem: false,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: Insets.xl),
                ),
                const SizedBox(height: Insets.l * 7),
              ],
            ),
          ),
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
                  checkoutItensProvider.totalValue,
                  moeda: true,
                )}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  final order = OrderModel(
                    const Uuid().v4(),
                    products: checkoutItensProvider.products,
                    total: checkoutItensProvider.totalValue.toString(),
                    user: user,
                  );
                  orderService.createOrder(order.toMap());
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
