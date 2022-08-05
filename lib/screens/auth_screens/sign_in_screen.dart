import 'package:chatz/constants/validations.dart';
import 'package:chatz/screens/auth_screens/widgets/bottom_bar.dart';
import 'package:chatz/screens/home_screen/home_screen.dart';

import 'package:chatz/widgets/app_bar.dart';
import 'package:chatz/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final Validations validations = Validations();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ListView(
                    children: [
                      const SizedBox(height: 50),
                      Image.asset(
                        'assets/login-bro.png',
                        height: 250,
                      ),
                      const SizedBox(height: 30),
                      AuthTextField(
                          labelText: 'Email address',
                          controller: emailController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return validations.emailValidation;
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(val)) {
                              return (validations.emailValidation);
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      AuthTextField(
                          labelText: 'Password',
                          controller: passwordController,
                          obscureText: true,
                          validator: (val) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (val!.isEmpty) {
                              return validations.passwordValidation;
                            }
                            if (!regex.hasMatch(val)) {
                              return (validations.unvalidPassword);
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            if (!isKeyboardVisible)
              AuthBottomBar(
                  mainText: 'I\'m ready',
                  subText: '...and real',
                  onTapped: () {
                    if (_formKey.currentState!.validate()) {
                      loginUser(
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  })
          ]),
        ),
      ),
    );
  }

  Future loginUser(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            ),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(validations.noUserWithEmail),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(validations.wrongPassword),
        ));
      }
    }
  }
}
