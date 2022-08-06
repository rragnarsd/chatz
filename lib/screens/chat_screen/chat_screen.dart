import 'package:chatz/constants/colors.dart';
import 'package:chatz/screens/home_screen/widgets/search_box.dart';
import 'package:chatz/screens/profile_screen/profile_screen.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.group}) : super(key: key);

  final group;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

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
        title: const Text('Your Chat with...'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person),
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
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ConstColors.black,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(13),
                        ),
                        color: ConstColors.redOrange,
                      ),
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
