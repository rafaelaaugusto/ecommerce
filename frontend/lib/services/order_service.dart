import 'dart:convert';

import 'package:http/http.dart' as http;

class OrderService {
  final String apiUrl = 'http://192.168.15.6:3000/api/orders';

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
}
