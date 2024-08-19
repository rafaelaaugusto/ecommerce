import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/order_model.dart';

String host = dotenv.env['HOST'] ?? 'localhost';

class OrderService {
  final String apiUrl = 'http://$host:3000/api/orders';

  Future<bool> createOrder(OrderModel order) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(order.toMap()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create order');
    }
  }

  Future<List<OrderModel>> fetchOrders(String userId) async {
    final response = await http.get(
      Uri.parse('$apiUrl?userId=$userId'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      return data.map((order) => OrderModel.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
