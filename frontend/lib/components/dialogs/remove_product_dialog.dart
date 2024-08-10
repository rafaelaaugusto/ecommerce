import 'package:flutter/material.dart';

class RemoveProductDialog extends StatelessWidget {
  final Function() onPressed;

  const RemoveProductDialog({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remover produto'),
      content: const Text(
        'Tem certeza que deseja remover esse produto do carrinho?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancelar',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onPressed();
            Navigator.of(context).pop();
          },
          child: const Text('Sim'),
        ),
      ],
    );
  }
}
