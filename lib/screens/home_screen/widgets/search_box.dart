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
  final Icon? isPrefix;
  final TextEditingController? controller;
  final Function(String)? function;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      controller: controller,
      onChanged: function,
      decoration: InputDecoration(
        prefixIcon: isPrefix,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.black54),
        contentPadding: const EdgeInsets.only(left: 20),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
      ),
    );
  }
}
