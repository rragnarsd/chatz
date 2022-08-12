import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.validator,
    this.obscureText = false,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: ConstColors.black,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: ConstColors.black54,
        ),
        contentPadding: const EdgeInsets.only(
          left: 20,
        ),
        enabledBorder: UIStyles.borders,
        focusedBorder: UIStyles.borders,
        border: UIStyles.borders,
      ),
    );
  }
}
