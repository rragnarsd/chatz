import 'package:chatz/screens/chat_screen/widgets/chat_input_row.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  ChatInputRow(),
                ]),
          ),
        ),
      ),
    );
  }
}
