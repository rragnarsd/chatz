import 'dart:io';

import 'package:chatz/l10n/l10n.dart';
import 'package:chatz/provider/locale.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/screens/auth_screens/widgets/add_image_icon.dart';
import 'package:chatz/services/firebase.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:chatz/widgets/reusable_bottom_sheet.dart';
import 'package:chatz/widgets/reusable_dialog.dart';
import 'package:provider/provider.dart';

part './widgets/profile_image_row.dart';
part './widgets/profile_info_row.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.userData}) : super(key: key);

  final AsyncSnapshot<dynamic>? userData;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();

  String? value;
  bool changeLanguage = true;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleNotifier>(context);
    final locale = provider.locale;
    return Scaffold(
      appBar: CustomAppbar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        ),
        title: Text(AppLocalizations.of(context)!.yourProfile),
        withProfile: false,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: firestore.collection('users').doc(_user!.uid).snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            var userData = snapshot.data;
            if (snapshot.hasError) {
              return Text(AppLocalizations.of(context)!.someErrorOccured);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                    top: 120,
                    left: 20,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: UIStyles.profileDecoration.copyWith(
                        color: ConstColors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            userData['name'] ?? '',
                            style: TextStyles.style18Bold,
                          ),
                          const SizedBox(height: 20),
                          ProfileInfoRow(
                            userData: userData,
                            userKey:
                                '${AppLocalizations.of(context)!.userName}:',
                            userValue: userData['name'] ?? '',
                            isChangeable: true,
                            function: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ReusableDialog(
                                      nameController: _nameController,
                                      hintText:
                                          '${AppLocalizations.of(context)!.enterNewName}..',
                                      header: AppLocalizations.of(context)!
                                          .updateName,
                                      onUpdate: () {
                                        FirebaseService()
                                            .updateName(_nameController.text)
                                            .then((value) =>
                                                Navigator.pop(context));
                                      },
                                    );
                                  });
                            },
                          ),
                          const Divider(thickness: 1),
                          const SizedBox(height: 10),
                          ProfileInfoRow(
                            userData: userData,
                            userKey:
                                '${AppLocalizations.of(context)!.userEmail}:',
                            userValue: userData['email'] ?? '',
                          ),
                          const SizedBox(height: 10),
                          const Divider(thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${AppLocalizations.of(context)!.changeLanguage}:',
                                style: TextStyles.style14.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Row(
                                children: [
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      borderRadius: BorderRadius.circular(13),
                                      value: locale,
                                      items: L10n.all.map((locale) {
                                        final country =
                                            L10n.language(locale.languageCode);
                                        return DropdownMenuItem(
                                          value: locale,
                                          onTap: () {
                                            final provider =
                                                Provider.of<LocaleNotifier>(
                                                    context,
                                                    listen: false);
                                            provider.setLocale(locale);
                                          },
                                          child: Center(
                                            child: Text(
                                              country,
                                              style: TextStyles.style14,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (_) {},
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 60,
                    child: ProfileImageRow(userData: userData),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
