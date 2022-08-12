import 'package:chatz/constants/validations.dart';
import 'package:chatz/routes/router.dart';
import 'package:chatz/screens/auth_screens/widgets/auth_button.dart';
import 'package:chatz/screens/auth_screens/widgets/bottom_bar.dart';
import 'package:chatz/services/firebase.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                          labelText: AppLocalizations.of(context)!.userEmail,
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
                          labelText: AppLocalizations.of(context)!.password,
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
                      AuthButton(
                        mainText:
                            '${AppLocalizations.of(context)!.noAccountYet}? ',
                        subText:
                            '${AppLocalizations.of(context)!.registerHere}!',
                        function: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.signUpcreen,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (!isKeyboardVisible)
              AuthBottomBar(
                  mainText: AppLocalizations.of(context)!.imReady,
                  subText: '...${AppLocalizations.of(context)!.andReal}!',
                  onTapped: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseService()
                          .loginUser(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context,
                          )
                          .then((value) => Navigator.pushNamedAndRemoveUntil(
                              context, AppRouter.homeScreen, (route) => false));
                    }
                  })
          ]),
        ),
      ),
    );
  }
}
