import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/order_model.dart';

class OrderService {
  final String apiUrl = 'http://192.168.15.5:3000/api/orders';

  Future<bool> createOrder(Map<String, dynamic> orderData) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(orderData),
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
