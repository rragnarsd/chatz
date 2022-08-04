import 'package:flutter/material.dart';

class ChatSearchBox extends StatelessWidget {
  const ChatSearchBox({
    Key? key,
    required this.hintText,
    this.isPrefix,
  }) : super(key: key);

  final String hintText;
  final Icon? isPrefix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: isPrefix,
        hintText: hintText,
        labelStyle: TextStyle(color: Colors.black54),
        contentPadding: EdgeInsets.only(left: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
      ),
    );
  }
}
