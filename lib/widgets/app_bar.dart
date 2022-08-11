import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/routes/router.dart';
import 'package:chatz/services/firebase.dart';
import 'package:chatz/widgets/reusable_elevated_button.dart';
import 'package:chatz/widgets/reusable_outline_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    required this.leading,
    required this.title,
    this.withProfile = true,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final bool? withProfile;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseService().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.data();
            var imgUrl = data!['imgUrl'];
            return AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: false,
              leading: leading,
              iconTheme: const IconThemeData(
                color: ConstColors.black87,
              ),
              actions: [
                withProfile == true
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.profileScreen,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 20,
                            child: Hero(
                              tag: 'profileImg',
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(imgUrl),
                              ),
                            ),
                          ),
                        ))
                    : IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                'Are you sure you want to sign out?',
                                style: TextStyles.style14,
                              ),
                              actions: [
                                const ReusableOutlineButton(text: 'Cancel'),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: ReusableElevatedButton(
                                    text: 'Continue',
                                    function: () {
                                      FirebaseService().signOut().then(
                                            (value) =>
                                                Navigator.pushReplacementNamed(
                                              context,
                                              AppRouter.landingScreen,
                                            ),
                                          );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.arrowRightFromBracket,
                        ),
                      )
              ],
              title: title,
              titleTextStyle: TextStyles.style16Bold.copyWith(
                color: ConstColors.black87,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
