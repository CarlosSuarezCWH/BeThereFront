import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const InputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 12,
          color: Color(0xFF8F8E8E),
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 10),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
