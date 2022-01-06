import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.isObscure = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(236, 89, 160, 1),)),
        border: OutlineInputBorder(),
        labelText: label,
      ),
    );
  }
}
