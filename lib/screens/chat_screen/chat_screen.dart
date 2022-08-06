import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/routes/router.dart';
import 'package:chatz/screens/home_screen/widgets/search_box.dart';
import 'package:chatz/services/firebase.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.group}) : super(key: key);

  final dynamic group;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  dynamic data;

  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    FirebaseService().getUserData().then((value) {
      data = value;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Your Chat with...'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRouter.profileScreen);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: ConstColors.darkerCyan,
                backgroundImage:
                    data == null ? null : NetworkImage(data['imgUrl']),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection('chatz')
                        .doc(widget.group)
                        .collection('messages')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Text('No chats yet!');
                      }
                      return ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: snapshot.data!.docs.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];
                            var currentUser =
                                data['sender'] == auth.currentUser!.email;

                            return Row(
                              children: [
                                if (currentUser) const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(13),
                                        topRight: const Radius.circular(13),
                                        bottomLeft: currentUser
                                            ? const Radius.circular(13)
                                            : Radius.zero,
                                        bottomRight: !currentUser
                                            ? const Radius.circular(13)
                                            : Radius.zero),
                                    color: currentUser
                                        ? ConstColors.greenCyan
                                        : Colors.grey.shade300,
                                  ),
                                  child: Text(snapshot.data!.docs.reversed
                                      .toList()[index]['message']),
                                ),
                                if (!currentUser) const Spacer(),
                              ],
                            );
                          });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: ChatSearchBox(
                      controller: controller,
                      hintText: 'Type your messages...',
                    )),
                    const SizedBox(width: 15),
                    Container(
                      decoration: UIStyles.chatDecoration,
                      child: IconButton(
                        onPressed: () {
                          firestore
                              .collection('chatz')
                              .doc(widget.group)
                              .collection('messages')
                              .add({
                            'sender': auth.currentUser!.email,
                            'message': controller.text,
                            'time': DateFormat('hh:mm').format(
                              DateTime.now(),
                            )
                          });
                          controller.clear();
                          setState(() {});
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
