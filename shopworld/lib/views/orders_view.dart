import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/empty_data_component.dart';
import '../components/layout_box_component.dart';
import '../components/order_item_component.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';
import '../viewmodels/user_view_model.dart';

class OrdersView extends ConsumerStatefulWidget {
  const OrdersView({super.key});

  @override
  ConsumerState<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends ConsumerState<OrdersView> {
  OrderService apiService = OrderService();
  List<OrderModel>? orders;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider).currentUser;
    if (user != null) {
      Future.delayed(Duration.zero, () => _fetchOrdersData(user.id));
    } else {
      orders = [];
    }
  }

  Future<void> _fetchOrdersData(String userId) async {
    try {
      orders = await apiService.fetchOrders(userId);
    } catch (e) {
      hasError = true;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasError
          ? const Center(
              child: Text('Erro ao carregar pedidos.'),
            )
          : orders.isNotBlank
              ? LayoutBox(
                  child: Padding(
                    padding: const EdgeInsets.all(Insets.l * 2),
                    child: Column(
                      children: [
                        Text(
                          'Minhas compras',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: Insets.xxl),
                        Expanded(
                          child: ListView.separated(
                            itemCount: orders!.length,
                            itemBuilder: (context, index) => OrderItem(
                              order: orders![index],
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: Insets.xl),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : orders == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: Insets.xxs,
                      ),
                    )
                  : const EmptyData(
                      text: 'Você ainda não realizou nenhuma compra.',
                    ),
    );
  }
}
