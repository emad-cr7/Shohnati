import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIconWidget;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    this.title,
    this.controller,
    this.prefixIcon,
    this.prefixIconWidget,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: title,
        prefixIcon:
            prefixIconWidget ??
            (prefixIcon != null
                ? Icon(prefixIcon, color: const Color(0xff757684))
                : null),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
