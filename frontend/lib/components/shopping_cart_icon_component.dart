import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';

class ShoppingCartIcon extends StatefulWidget {
  final Function() onPressed;
  final int productCount;

  const ShoppingCartIcon({
    super.key,
    required this.onPressed,
    required this.productCount,
  });

  @override
  State<ShoppingCartIcon> createState() => _ShoppingCartIconState();
}

class _ShoppingCartIconState extends State<ShoppingCartIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(Insets.xxl * 2),
          onTap: widget.onPressed,
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: Insets.xl,
              horizontal: Insets.xxl,
            ),
            child: Icon(Icons.shopping_cart),
          ),
        ),
        Positioned(
          left: 25,
          bottom: 30,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(
                Insets.xxl,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.xs),
              child: Text(
                widget.productCount.toString(),
                style: const TextStyle(
                  fontSize: Insets.l,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
