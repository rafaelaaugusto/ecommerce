import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/order_item_component.dart';
import '../models/order_model.dart';
import '../providers/user_provider.dart';
import '../services/order_service.dart';

class OrdersView extends ConsumerStatefulWidget {
  const OrdersView({super.key});

  @override
  ConsumerState<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends ConsumerState<OrdersView> {
  OrderService apiService = OrderService();
  List<OrderModel> orders = [];
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider).currentUser;
    if (user != null) {
      Future.delayed(Duration.zero, () => _fetchOrdersData(user.id));
    }
  }

  Future<void> _fetchOrdersData(String userId) async {
    try {
      orders = await apiService.fetchOrders(userId);
    } catch (e) {
      hasError = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider).currentUser;

    return Scaffold(
      body: hasError
          ? const Center(
              child: Text('Erro ao carregar pedidos.'),
            )
          : orders.isNotBlank
              ? Column(
                  children: [
                    const Text('Minhas compras'),
                    Expanded(
                      child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) => OrderItem(
                          order: orders[index],
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: user != null
                      ? const CircularProgressIndicator(
                          strokeWidth: Insets.xxs,
                        )
                      : const Text('Você ainda não realizou nenhuma compra.'),
                ),
    );
  }
}
