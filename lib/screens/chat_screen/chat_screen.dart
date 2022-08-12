import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/screens/shared/widgets/app_bar.dart';
import 'package:chatz/screens/shared/widgets/search_box.dart';
import 'package:chatz/services/firebase.dart';
import 'package:chatz/utils/functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part './widgets/chats_widget.dart';
part './widgets/chat_rich_text.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.currentUser,
    required this.chatUser,
  }) : super(key: key);

  final String currentUser;
  final String chatUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController controller = TextEditingController();

  String message = '';

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
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
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
              ChatsWidget(widget: widget, auth: auth),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ChatSearchBox(
                        controller: controller,
                        hintText:
                            '${AppLocalizations.of(context)!.typeMessage}....',
                        function: (value) {
                          setState(() {
                            message = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      decoration: UIStyles.chatDecoration,
                      child: IconButton(
                        onPressed: () {
                          message.trim().isEmpty
                              ? null
                              : FirebaseService().chat(
                                  userId: widget.chatUser,
                                  msg: message,
                                );
                          controller.clear();
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.paperPlane,
                        ),
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
