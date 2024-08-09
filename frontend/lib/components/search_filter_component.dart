import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:frontend/theme/colors_theme.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.xxl * 2),
      child: TextField(
        cursorColor: onSurface,
        onChanged: (_) {},
        decoration: const InputDecoration(
          hintText: 'O que você precisa?',
        ),
      ),
    );
  }
}
