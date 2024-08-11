import 'package:flutter/material.dart';

class ActionAlertDialog extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final String subtitle;

  const ActionAlertDialog({
    super.key,
    required this.onPressed,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(subtitle),
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
