import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:flutter/material.dart';

class ChatSearchBox extends StatelessWidget {
  const ChatSearchBox({
    Key? key,
    required this.hintText,
    this.isPrefix,
    this.controller,
    this.function,
  }) : super(key: key);

  final String hintText;
  final Widget? isPrefix;
  final TextEditingController? controller;
  final Function(String)? function;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: ConstColors.black,
      controller: controller,
      onChanged: function,
      decoration: InputDecoration(
        prefixIcon: isPrefix,
        hintText: hintText,
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
