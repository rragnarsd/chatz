import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/data/models/user_model.dart';
import 'package:chatz/screens/chat_screen/widgets/chat_rich_text.dart';
import 'package:chatz/screens/chat_screen/widgets/chats_widget.dart';
import 'package:chatz/screens/home_screen/widgets/search_box.dart';
import 'package:chatz/services/firebase.dart';

import 'package:chatz/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.user,
    this.idUser,
  }) : super(key: key);

  final UserModel user;
  final String? idUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String message = '';

  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: ChatRichText(widget: widget),
        withProfile: true,
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              ChatsWidget(auth: auth, idUser: widget.user.uid!),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: ChatSearchBox(
                      controller: controller,
                      hintText: 'Type your message...',
                      function: (value) {
                        setState(() {
                          message = value;
                        });
                      },
                    )),
                    const SizedBox(width: 15),
                    Container(
                      decoration: UIStyles.chatDecoration,
                      child: IconButton(
                        onPressed: () {
                          message.trim().isEmpty
                              ? null
                              : FirebaseService().createChat(
                                  widget.user.uid!,
                                  message,
                                );
                          controller.clear();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

