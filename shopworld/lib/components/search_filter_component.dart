import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';

class SearchFilter extends StatelessWidget {
  final Function(String) filterByText;

  const SearchFilter({
    super.key,
    required this.filterByText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.xxl * 2),
      child: TextField(
        onChanged: filterByText,
        cursorColor: Theme.of(context).colorScheme.onSurface,
        decoration: const InputDecoration(
          hintText: 'O que você precisa?',
        ),
      ),
    );
  }
}
