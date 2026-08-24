import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextFormField({
    super.key,
    required this.title,
    required this.controller,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: title,
        prefixIcon: prefixIcon != null
            ? Icon(
          prefixIcon,
          color: const Color(0xff757684),
        )
            : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}