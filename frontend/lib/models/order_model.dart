import 'customer_model.dart';
import 'product_model.dart';

class Order {
  final String id;
  final CustomerModel customer;
  final List<ProductModel> products;

  Order(
    this.id, {
    required this.customer,
    required this.products,
  });
}
