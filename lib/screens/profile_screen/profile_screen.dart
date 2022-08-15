import 'dart:io';

import 'package:chatz/L10n/l10n.dart';
import 'package:chatz/provider/img_provider.dart';
import 'package:chatz/screens/shared/widgets/app_bar.dart';
import 'package:chatz/screens/shared/widgets/app_bottom_sheet.dart';
import 'package:chatz/screens/shared/widgets/app_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/constants/ui_styles.dart';

import 'package:chatz/provider/locale_provider.dart';
import 'package:chatz/screens/auth_screens/widgets/add_image_icon.dart';
import 'package:chatz/services/firebase.dart';

part 'widgets/dropdown.dart';
part 'widgets/image_row.dart';
part 'widgets/info_row.dart';
part 'widgets/body.dart';

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
    final provider = Provider.of<LocaleProvider>(context);
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

            return Body(
              userData: userData,
              nameController: _nameController,
              locale: locale,
            );
          },
        ),
      ),
    );
  }
}
