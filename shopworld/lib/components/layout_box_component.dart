import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LayoutBox extends StatelessWidget {
  final Widget child;

  const LayoutBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return child;
    }
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: child,
        ),
      ),
    );
  }
}
