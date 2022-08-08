import 'package:chatz/constants/colors.dart';
import 'package:chatz/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsWidget extends StatelessWidget {
  const ChatsWidget({
    Key? key,
    required this.auth,
    required this.idUser,
  }) : super(key: key);

  final String idUser;
  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseService().getChat(idUser),
        builder: (context, AsyncSnapshot snapshot) {
          final messages = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Say hi!'));
          }
          return Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                reverse: true,
                itemCount: messages!.docs.length,
                itemBuilder: (context, index) {
                  final message = messages.docs[index];
                  var currentUser = message['uid'] == auth.currentUser!.uid;

                  return Row(
                    mainAxisAlignment: currentUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (!currentUser)
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey.shade400,
                          //TODO - networkimage
                          backgroundImage: NetworkImage(message['imgUrl']),
                        ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        constraints: const BoxConstraints(maxWidth: 160),
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
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
              ),
            ),
          );
        });
  }
}
