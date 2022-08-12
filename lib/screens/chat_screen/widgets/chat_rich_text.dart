part of '../chat_screen.dart';

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
        text: '${AppLocalizations.of(context)!.chatWith} ',
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
