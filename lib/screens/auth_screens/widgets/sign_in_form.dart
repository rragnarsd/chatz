import 'package:chatz/screens/shared/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:chatz/constants/validations.dart';
import 'package:chatz/routes/router.dart';
import 'package:chatz/screens/auth_screens/widgets/auth_button.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.validations,
    required this.passwordController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final Validations validations;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                mainText: '${AppLocalizations.of(context)!.noAccountYet}? ',
                subText: '${AppLocalizations.of(context)!.registerHere}!',
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
    );
  }
}
