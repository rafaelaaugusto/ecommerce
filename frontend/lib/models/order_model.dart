import 'product_model.dart';
import 'user_model.dart';

class Order {
  final String id;
  final UserModel customer;
  final List<ProductModel> products;
  final String total;

  Order(
    this.id, {
    required this.customer,
    required this.products,
    required this.total,
  });
}
