import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:chatz/constants/validations.dart';
import 'package:chatz/routes/router.dart';
import 'package:chatz/screens/auth_screens/widgets/bottom_bar.dart';
import 'package:chatz/screens/auth_screens/widgets/sign_in_form.dart';
import 'package:chatz/services/firebase.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
    var size = MediaQuery.of(context).size;
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(children: [
            SignInForm(
              formKey: _formKey,
              emailController: emailController,
              validations: validations,
              passwordController: passwordController,
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
