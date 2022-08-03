import 'package:chatz/screens/home_screen/home_screen.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:chatz/screens/auth_screens/widgets/avatar_row.dart';
import 'package:chatz/screens/auth_screens/widgets/bottom_bar.dart';
import 'package:chatz/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            const CustomAppBar(text: 'Sign Up'),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView(children: const [
                  SizedBox(height: 30),
                  SignUpAvatarRow(),
                  SizedBox(height: 20),
                  AuthTextField(labelText: 'Username'),
                  SizedBox(height: 20),
                  AuthTextField(labelText: 'Email address'),
                  SizedBox(height: 20),
                  AuthTextField(labelText: 'Password'),
                  SizedBox(height: 20),
                  AuthTextField(labelText: 'Re-type Password'),
                ]),
              ),
            ),
            if (!isKeyboardVisible)
              AuthBottomBar(
                mainText: 'Save and Continue',
                subText: 'Your data must be real',
                onTapped: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen())),
              )
          ]),
        ),
      ),
    );
  }
}
