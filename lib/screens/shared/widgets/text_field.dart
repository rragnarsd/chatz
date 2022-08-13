import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.validator,
      this.obscureText = false,
      this.keyBoardType})
      : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyBoardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyBoardType,
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
        focusedBorder: UIStyles.borders.copyWith(
          borderSide: const BorderSide(
            color: ConstColors.darkerCyan,
            width: 1.5,
          ),
        ),
        border: UIStyles.borders,
      ),
    );
  }
}
