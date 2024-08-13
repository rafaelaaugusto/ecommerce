import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  final String text;

  const EmptyData({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_rounded,
            color: Theme.of(context).colorScheme.onSecondary,
            size: Insets.xxl * 3,
          ),
          const SizedBox(height: Insets.l),
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
