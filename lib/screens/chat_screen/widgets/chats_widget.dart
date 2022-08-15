part of '../chat_screen.dart';

class ChatsWidget extends StatelessWidget {
  const ChatsWidget({
    Key? key,
    required this.widget,
    required this.auth,
    required this.imgUrl,
  }) : super(key: key);

  final ChatScreen widget;
  final FirebaseAuth auth;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseService().getChat(widget.chatUser),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: ConstColors.darkerCyan,
                ),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Expanded(
              child: Center(
                child: Text(
                  '${AppLocalizations.of(context)!.sayHi}!',
                  style: TextStyles.style14,
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            return Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    if (snapshot.hasData) {
                      final message = snapshot.data!.docs[index];
                      var currentUser =
                          message['user_id'] == auth.currentUser!.uid;

                      Timestamp t = message['createdAt'];
                      DateTime parsedDate = t.toDate();

                      return InkWell(
                        splashColor: ConstColors.transparent,
                        focusColor: ConstColors.transparent,
                        onDoubleTap: () {
                          FirebaseService().deleteChats(message.id);
                        },
                        child: Row(
                          mainAxisAlignment: currentUser
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (!currentUser)
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.grey.shade400,
                                backgroundImage: NetworkImage(imgUrl),
                              ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: currentUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  constraints:
                                      const BoxConstraints(maxWidth: 160),
                                  decoration: BoxDecoration(
                                    color: currentUser
                                        ? ConstColors.greenCyan
                                        : Colors.grey.shade300,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(13),
                                      topRight: const Radius.circular(13),
                                      bottomLeft: currentUser
                                          ? const Radius.circular(13)
                                          : Radius.zero,
                                      bottomRight: !currentUser
                                          ? const Radius.circular(13)
                                          : Radius.zero,
                                    ),
                                  ),
                                  child: Text(message['message']),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  Functions().convertToAgo(parsedDate, context),
                                  style:
                                      TextStyles.style12.copyWith(fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
