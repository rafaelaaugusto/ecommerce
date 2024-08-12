import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/order_item_component.dart';
import '../models/order_model.dart';
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
    Future.delayed(Duration.zero, () => _fetchOrdersData());
  }

  Future<void> _fetchOrdersData() async {
    try {
      orders = await apiService.fetchOrders();
    } catch (e) {
      hasError = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<OrderModel> orders = [];

    return Scaffold(
      body: Column(
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
      ),
    );
  }
}
