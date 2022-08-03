import 'package:flutter/material.dart';

class ChatSearchBox extends StatelessWidget {
  const ChatSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black87,
        ),
        hintText: 'Search',
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
