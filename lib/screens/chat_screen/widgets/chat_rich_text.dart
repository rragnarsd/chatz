import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/screens/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';

class ChatRichText extends StatelessWidget {
  const ChatRichText({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ChatScreen widget;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Your Chat with ',
        style: TextStyles.style16.copyWith(
          color: ConstColors.black87,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'ChatUser',
            //text: '${widget.chatUser}',
            style: TextStyles.style16Bold.copyWith(
              color: ConstColors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
