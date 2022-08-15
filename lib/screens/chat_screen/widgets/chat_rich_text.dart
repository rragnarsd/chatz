part of '../chat_screen.dart';

class ChatRichText extends StatelessWidget {
  const ChatRichText({
    Key? key,
    required this.userName,
  }) : super(key: key);

  final String userName;

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
            text: userName,
            style: TextStyles.style16Bold.copyWith(
              color: ConstColors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
