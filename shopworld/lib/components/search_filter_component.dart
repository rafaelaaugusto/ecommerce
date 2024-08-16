import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';

import 'layout_box_component.dart';

class SearchFilter extends StatelessWidget {
  final Function(String) filterByText;

  const SearchFilter({
    super.key,
    required this.filterByText,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBox(
      child: Padding(
        padding: const EdgeInsets.only(
          top: Insets.l * 2,
          bottom: Insets.xxl * 2,
        ),
        child: TextField(
          onChanged: filterByText,
          cursorColor: Theme.of(context).colorScheme.onSurface,
          decoration: const InputDecoration(
            hintText: 'O que você precisa?',
          ),
        ),
      ),
    );
  }
}
