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
    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              //TODO - add the username
              '${AppLocalizations.of(context)!.sureToDeleteTheChat} x?',
              style: TextStyles.style14,
            ),
            actions: [
              AppOutlineBtn(text: AppLocalizations.of(context)!.cancel),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: AppElevatedBtn(
                  text: AppLocalizations.of(context)!.xContinue,
                  function: () {
                    FirebaseService()
                        .deleteChats(message.id)
                        .then((value) => Navigator.pop(context));
                  },
                ),
              )
            ],
          ),
        );
      },
      background: Container(
        decoration: UIStyles.chatDecoration.copyWith(
          color: ConstColors.redOrange,
        ),
        child: const Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: FaIcon(
              FontAwesomeIcons.xmark,
            ),
          ),
        ),
      ),
      key: ValueKey<QueryDocumentSnapshot<Object?>>(
        message,
      ),
      //TODO - Check out the behaviour when navigating to the chatscreen
      child: InkWell(
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
      ),
    );
  }
}
