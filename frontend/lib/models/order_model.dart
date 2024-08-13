import 'product_model.dart';
import 'user_model.dart';

class OrderModel {
  final String id;
  final UserModel user;
  final List<ProductModel> products;
  final String total;

  OrderModel({
    required this.id,
    required this.user,
    required this.products,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> data) {
    final products = (data['products'] as Iterable)
        .map((product) => ProductModel.fromJson(product))
        .toList();

    return OrderModel(
      id: data['id'],
      user: UserModel.fromJson(data['user']),
      products: products,
      total: data['total'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'products': products.map((product) => product.toMap()).toList(),
      'total': total,
    };
  }
}
