import 'package:flutter/material.dart';

class CustomTextFormFiedl extends StatelessWidget {
  String? hintText;
  String? labelText;
  TextEditingController? controller;
  String? Function(String?)? validator;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  bool obscureText;
  Widget? suffixIcon;

  CustomTextFormFiedl({
    super.key,
    this.hintText,
    this.labelText,
    required this.controller,
    required this.validator,
    required this.textInputAction,
    required this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.grey.shade700),
      cursorColor: Theme.of(context).colorScheme.secondary,
      validator: validator,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          hintText: hintText,
          labelText: labelText,
          filled: true,
          fillColor: Colors.grey.shade200,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          // labelStyle: TextStyle(fontFamily: 'Arial', fontSize: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary))),
    );
  }
}
