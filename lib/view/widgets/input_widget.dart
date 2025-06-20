import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final bool obscureText;
  final String? errorText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const InputWidget({
    super.key,
    required this.textEditingController,
    required this.obscureText,
    required this.label,
    this.errorText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final responsive = (double size) => width * size / 375;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive(8)),
      child: TextField(
        obscureText: obscureText,
        controller: textEditingController,
        style: TextStyle(fontSize: responsive(14)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: responsive(14)),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: responsive(13), color: Colors.grey),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsive(15)),
          ),
          errorText: errorText,
          contentPadding: EdgeInsets.symmetric(
            vertical: responsive(12),
            horizontal: responsive(16),
          ),
        ),
      ),
    );
  }
}
