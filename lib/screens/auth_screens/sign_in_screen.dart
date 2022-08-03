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
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(height: 30),
                AuthTextField(labelText: 'Email address'),
                SizedBox(height: 20),
                AuthTextField(labelText: 'Password'),
                SizedBox(height: 20),
              ],
            ),
            const Spacer(),
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
