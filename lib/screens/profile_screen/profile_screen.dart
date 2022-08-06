import 'dart:developer';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/screens/landing_screen/landing_screen.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;

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
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(_user!.uid)
              .get(),
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
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            userData['name'] ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            userData['email'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.8,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              signOut().then(
                                (value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LandingScreen(),
                                  ),
                                ),
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

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final dynamic userData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/arrow.png',
          height: 40,
        ),
        const SizedBox(width: 20),
        userData['imgUrl'] != null
            ? CircleAvatar(
                radius: 64,
                backgroundColor: ConstColors.greenCyan,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userData['imgUrl']),
                  radius: 60,
                ),
              )
            : const CircleAvatar(radius: 60),
        const SizedBox(width: 20),
        RotatedBox(
          quarterTurns: 2,
          child: Image.asset(
            'assets/arrow.png',
            height: 40,
          ),
        ),
      ],
    );
  }
}
