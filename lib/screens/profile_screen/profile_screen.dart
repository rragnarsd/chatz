import 'dart:developer';

import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/routes/router.dart';
import 'package:chatz/screens/profile_screen/widgets/profile_row.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.userData}) : super(key: key);

  final AsyncSnapshot<dynamic>? userData;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Your Profile'),
        actions: const [],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: firestore.collection('users').doc(_user!.uid).get(),
          builder: (context, AsyncSnapshot snapshot) {
            var userData = snapshot.data;
            if (snapshot.hasError) {
              log('Error');
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
                      decoration: UIStyles.profileDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            userData['name'] ?? '',
                            style: TextStyles.style18Bold,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            userData['email'] ?? '',
                            style: TextStyles.style16,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              signOut().then(
                                (value) => Navigator.pushReplacementNamed(
                                    context, AppRouter.landingScreen),
                              );
                            },
                            child: const Text('Sign out'),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 60,
                    child: ProfileRow(userData: userData),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
