import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  const Alert({
    Key? key,
  }) : super(key: key);

  // final TextEditingController controller;
  // final String label;
  // final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: const Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
