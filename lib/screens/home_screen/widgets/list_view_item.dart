part of '../home_screen.dart';

class ListViewItem extends StatelessWidget {
  const ListViewItem({
    Key? key,
    required this.message,
    required this.auth,
    required this.parsedDate,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> message;
  final FirebaseAuth auth;
  final DateTime parsedDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChatScreen(
              chatUser: message['conversation_id'],
              currentUser: auth.currentUser!.uid,
            );
          }),
        );
      },
      child: ChatTile(
        name: 'Sender',
        //name: message['user_id'],
        lastMessage: Functions().convertToAgo(parsedDate, context),
        message: message['message'],
      ),
    );
  }
}
