import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/screens/chat_screen/chat_screen.dart';
import 'package:chatz/screens/home_screen/widgets/search_box.dart';
import 'package:chatz/services/firebase.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchName = '';
  final TextEditingController controller = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

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
        title: const Text('Find friends!'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: ChatSearchBox(
                controller: controller,
                hintText: 'Search',
                isPrefix: const Icon(Icons.search),
                function: (value) {
                  setState(() {
                    FirebaseService().searchUsers(controller.text);
                  });
                },
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseService().getUsers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.data!.docs
                      .where((user) => user['name']
                          .toString()
                          .toLowerCase()
                          .contains(controller.text.toLowerCase()))
                      .isEmpty) {
                    return const Center(
                      child: Text(
                        'No user found',
                        style: TextStyles.style14,
                      ),
                    );
                  }

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ...snapshot.data!.docs
                                .where((user) => user['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(controller.text.toLowerCase()))
                                .map((info) {
                              final String name = info['name'];
                              final String imgUrl = info['imgUrl'];
                              final String email = info['email'];
                              final String uid = info['uid'];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Card(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return ChatScreen(
                                            chatUser: uid,
                                            currentUser: auth.currentUser!.uid,
                                          );
                                        }),
                                      );
                                    },
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(13),
                                      ),
                                    ),
                                    title: Text(name),
                                    subtitle: Text(email),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.message,
                                      ),
                                      onPressed: () {},
                                    ),
                                    leading: Image.network(
                                      imgUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            })
                          ]),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
