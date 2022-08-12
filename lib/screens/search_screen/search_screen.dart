import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/screens/chat_screen/chat_screen.dart';
import 'package:chatz/screens/home_screen/home_screen.dart';
import 'package:chatz/screens/search_screen/widgets/search_loading.dart';
import 'package:chatz/services/firebase.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
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
                isPrefix: const SizedBox(
                  width: 55,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: ConstColors.black54,
                      ),
                    ),
                  ),
                ),
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SearchLoading();
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GridView(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.9,
                          ),
                          children: [
                            ...snapshot.data!.docs
                                .where((user) => user['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(controller.text.toLowerCase()))
                                .map((info) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return ChatScreen(
                                        chatUser: info['uid'],
                                        currentUser: auth.currentUser!.uid,
                                      );
                                    }),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 5,
                                      right: 4,
                                      top: 8,
                                      child: Container(
                                        height: 180,
                                        decoration:
                                            UIStyles.chatDecoration.copyWith(
                                          color: ConstColors.lightShadeOrange,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      bottom: 13,
                                      child: Container(
                                        height: 180,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        padding: const EdgeInsets.all(10),
                                        decoration:
                                            UIStyles.chatDecoration.copyWith(
                                          color: ConstColors.white,
                                        ),
                                        child: Column(children: [
                                          Container(
                                            width: 140,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  info['imgUrl'],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                info['name'],
                                                style: TextStyles.style14,
                                              ),
                                              const SizedBox(width: 10),
                                              const FaIcon(
                                                FontAwesomeIcons.comment,
                                                color: ConstColors.redOrange,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            info['email'],
                                            style: TextStyles.style14Bold,
                                          ),
                                        ]),
                                      ),
                                    )
                                  ],
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
