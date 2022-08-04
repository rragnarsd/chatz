import 'package:chatz/screens/home_screen/widgets/search_box.dart';
import 'package:flutter/material.dart';

class ChatInputRow extends StatelessWidget {
  const ChatInputRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Expanded(
              child: ChatSearchBox(
            hintText: 'Type your messages...',
          )),
          const SizedBox(width: 15),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(13),
              ),
              color: const Color(0xffFFAD85),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }
}