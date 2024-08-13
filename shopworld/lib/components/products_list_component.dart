import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import 'product_item_component.dart';

class ProductsList extends StatefulWidget {
  final List<ProductModel> products;

  const ProductsList({
    super.key,
    required this.products,
  });

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: Insets.l * 2,
          runSpacing: Insets.l * 2,
          children: widget.products
              .map(
                (product) => ProductItem(product: product),
              )
              .toList(),
        ),
      ),
    );
  }
}
