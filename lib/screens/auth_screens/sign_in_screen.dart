import 'package:chatz/screens/auth_screens/widgets/bottom_bar.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:chatz/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            const CustomAppBar(text: 'Sign in'),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView(
                  children: [
                    Image.asset(
                      'assets/login-bro.png',
                      height: 250,
                    ),
                    const SizedBox(height: 30),
                    const AuthTextField(labelText: 'Email address'),
                    const SizedBox(height: 20),
                    const AuthTextField(labelText: 'Password'),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            if (!isKeyboardVisible)
              const SignUpBottomBar(
                mainText: 'I\'m ready',
                subText: '...and real',
              )
          ]),
        ),
      ),
    );
  }
}
