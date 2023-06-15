import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextInputType type;
  final TextEditingController controller;

  const TextFormFieldWidget(
      {super.key,
      required this.hint,
      required this.icon,
      required this.obscureText,
      required this.type,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: type,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.7),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.white.withOpacity(.7),
          size: 30,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please add your $hint';
        }
        return null;
      },
    );
  }
}
