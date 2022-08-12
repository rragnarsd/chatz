import 'package:chatz/screens/shared/widgets/app_bar.dart';
import 'package:chatz/screens/shared/widgets/app_elevated_btn.dart';
import 'package:chatz/screens/shared/widgets/app_outline_btn.dart';
import 'package:chatz/screens/shared/widgets/circle_icon_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/screens/chat_screen/chat_screen.dart';
import 'package:chatz/screens/home_screen/widgets/home_loading.dart';
import 'package:chatz/screens/search_screen/search_screen.dart';
import 'package:chatz/services/firebase.dart';
import 'package:chatz/utils/functions.dart';

part 'widgets/chat_tile.dart';
part 'widgets/floating_action_btn.dart';
part 'widgets/list_view_item.dart';
part 'widgets/list_view_empty.dart';

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
        title: Text(
          'Chatz',
          style: GoogleFonts.boogaloo().copyWith(
            color: ConstColors.black87,
            fontSize: 30,
          ),
        ),
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
                  child: Text(
                    AppLocalizations.of(context)!.yourMessages,
                    style: TextStyles.style16Bold,
                  ),
                ),
                const SizedBox(height: 20),
                StreamBuilder(
                  stream: FirebaseService().getChats(auth.currentUser!.uid),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const HomeLoading();
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return const ListViewEmpty();
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

                            return ListViewItem(
                              message: message,
                              auth: auth,
                              parsedDate: parsedDate,
                            );
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
}
