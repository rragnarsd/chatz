import 'dart:developer';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/screens/chat_screen/chat_screen.dart';
import 'package:chatz/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsWidget extends StatelessWidget {
  const ChatsWidget({
    Key? key,
    required this.widget,
    required this.auth,
  }) : super(key: key);

  final ChatScreen widget;
  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseService().getChat(widget.chatUser),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return const Expanded(
              child: Center(
                child: Text(
                  'Say hi!',
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
                    final message = snapshot.data!.docs[index];

                    if (message['sender'] == auth.currentUser!.uid ||
                        message['receiver'] == auth.currentUser!.uid ||
                        message['sender'] == widget.chatUser ||
                        message['receiver'] == widget.chatUser) {
                      var currentUser =
                          message['sender'] == auth.currentUser!.uid;

                      log(message['sender']);
                      log(message['receiver']);

                      return Row(
                        mainAxisAlignment: currentUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!currentUser)
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.grey.shade400,
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
