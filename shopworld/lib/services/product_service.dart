import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

String host = dotenv.env['HOST'] ?? 'localhost';

class ProductService {
  final String apiUrl = 'http://$host:3000/api/products';

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      return data.map((product) => ProductModel.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
