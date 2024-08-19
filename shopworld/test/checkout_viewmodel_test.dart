import 'package:flutter_test/flutter_test.dart';
import 'package:shopworld/models/product_model.dart';
import 'package:shopworld/viewmodels/checkout_view_model.dart';

void main() {
  late CheckoutViewModel viewModel;

  setUp(() {
    viewModel = CheckoutViewModel();
  });

  test('Initial product count should be zero', () {
    expect(viewModel.productCount, 0);
  });

  test('Initial product total value should be zero', () {
    expect(viewModel.totalValue, 0.0);
  });

  test('Adding a product should increase product count and total value', () {
    final product = ProductModel(id: '1', name: 'Test Product', price: '10.00');

    viewModel.addProduct(product);

    expect(viewModel.productCount, 1);
    expect(viewModel.totalValue, 10.00);
  });

  test('Adding multiple products should work correctly', () {
    final productA = ProductModel(id: '1', name: 'Product 1', price: '5.00');
    final productB = ProductModel(id: '2', name: 'Product 2', price: '15.00');

    viewModel.addProducts([productA, productB]);

    expect(viewModel.productCount, 2);
    expect(viewModel.totalValue, 20.00);
  });

  test('Removing products should clear the list and reset the total value', () {
    final product = ProductModel(id: '1', name: 'Test Product', price: '10.00');

    viewModel.addProduct(product);
    viewModel.removeProducts();

    expect(viewModel.productCount, 0);
    expect(viewModel.totalValue, 0.0);
  });

  test('Adding products should clear previous products', () {
    final productA = ProductModel(id: '1', name: 'Product 1', price: '5.00');
    final productB = ProductModel(id: '2', name: 'Product 2', price: '15.00');

    viewModel.addProduct(productA);
    viewModel.addProducts([productB]);

    expect(viewModel.productCount, 1);
    expect(viewModel.totalValue, 15.00);
  });
}
