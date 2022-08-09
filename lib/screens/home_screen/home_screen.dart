import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/data/models/user_model.dart';
import 'package:chatz/screens/chat_screen/chat_screen.dart';
import 'package:chatz/screens/home_screen/widgets/chat_tile_body.dart';
import 'package:chatz/screens/home_screen/widgets/floating_action_btn.dart';
import 'package:chatz/services/firebase.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text('Your Chatz'),
        withProfile: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Text(
                    'Your messages',
                    style: TextStyles.style16Bold,
                  ),
                ),
                const SizedBox(height: 20),
                StreamBuilder(
                  stream: FirebaseService().getChat(auth.currentUser!.uid),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text('No chats yet'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var message = snapshot.data!.docs[index];
                            Timestamp t = message['createdAt'];
                            DateTime parsedDate = t.toDate();

                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return ChatScreen(
                                        user: UserModel(
                                            email: message['name'],
                                            imgUrl: message['imgUrl'],
                                            lastMessage:
                                                message['createdAt'].toDate(),
                                            name: message['name'],
                                            uid: message['uid']),
                                      );
                                    }),
                                  );
                                },
                                child: ChatTileBody(
                                  name: message['name'],
                                  image: message['imgUrl'],
                                  lastMessage: convertToAgo(parsedDate),
                                  message: message['message'],
                                ));
                          },
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const FloatingActionButtonAdd(),
    );
  }

  String convertToAgo(DateTime input) {
    Duration timeAgo = DateTime.now().difference(input);

    if (timeAgo.inDays >= 1) {
      return '${timeAgo.inDays} day(s) ago';
    } else if (timeAgo.inHours >= 1) {
      return '${timeAgo.inHours} hour(s) ago';
    } else if (timeAgo.inMinutes >= 1) {
      return '${timeAgo.inMinutes} minute(s) ago';
    } else if (timeAgo.inSeconds >= 1) {
      return '${timeAgo.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }
}
