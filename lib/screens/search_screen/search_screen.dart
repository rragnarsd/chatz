import 'package:chatz/screens/shared/widgets/app_bar.dart';
import 'package:chatz/screens/shared/widgets/search_box.dart';
import 'package:chatz/screens/shared/widgets/shimmer_loading.dart';
import 'package:chatz/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/screens/chat_screen/chat_screen.dart';

part 'widgets/search_result.dart';
part 'widgets/search_loading.dart';

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
        title: Text('${AppLocalizations.of(context)!.findFriends}!'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: ChatSearchBox(
                controller: controller,
                hintText: AppLocalizations.of(context)!.search,
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
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noUserFound,
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
                              return SearchResult(
                                auth: auth,
                                chatUser: info['uid'],
                                email: info['email'],
                                imgUrl: info['imgUrl'],
                                name: info['name'],
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
