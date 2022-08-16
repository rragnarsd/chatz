import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/validations.dart';
import 'package:chatz/providers/img_provider.dart';
import 'package:chatz/routes/router.dart';
import 'package:chatz/screens/auth_screens/widgets/add_image_icon.dart';
import 'package:chatz/screens/auth_screens/widgets/auth_button.dart';
import 'package:chatz/screens/auth_screens/widgets/bottom_bar.dart';
import 'package:chatz/screens/shared/widgets/app_bottom_sheet.dart';
import 'package:chatz/screens/shared/widgets/text_field.dart';
import 'package:chatz/services/firebase.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final Validations validations = Validations();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    File? pickedImage =
        Provider.of<ImgProvider>(context, listen: true).pickedImage;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: size.height * 0.75,
                  width: size.width * 0.9,
                  child: ListView(children: [
                    const SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/arrow.png',
                          height: 40,
                        ),
                        const SizedBox(width: 20),
                        Stack(children: [
                          CircleAvatar(
                            radius: 47,
                            backgroundColor: ConstColors.black87,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: ConstColors.lightBlueCyan,
                              backgroundImage: pickedImage == null
                                  ? null
                                  : FileImage(pickedImage),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: ConstColors.transparent,
                                    isDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      return AppBottomSheet(
                                        fromCamera: () {
                                          Provider.of<ImgProvider>(context,
                                                  listen: false)
                                              .pickImageFromCamera(pickedImage);
                                          Navigator.pop(context);
                                        },
                                        fromGallery: () {
                                          Provider.of<ImgProvider>(context,
                                                  listen: false)
                                              .pickImageFromGallery(
                                                  pickedImage);
                                          Navigator.pop(context);
                                        },
                                      );
                                    });
                              },
                              child: const AddImageIcon(
                                iconSize: 14,
                                backgroundColor: ConstColors.white,
                                iconColor: ConstColors.black87,
                              ),
                            ),
                          )
                        ]),
                        const SizedBox(width: 20),
                        RotatedBox(
                          quarterTurns: 2,
                          child: Image.asset(
                            'assets/arrow.png',
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    AuthTextField(
                      labelText: AppLocalizations.of(context)!.userName,
                      controller: nameController,
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{3,}$');
                        if (value!.isEmpty) {
                          return validations.nameValidation;
                        }
                        if (!regex.hasMatch(value)) {
                          return (validations.unvalidName);
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                        labelText: AppLocalizations.of(context)!.userEmail,
                        controller: emailController,
                        keyBoardType: TextInputType.emailAddress,
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
                    AuthTextField(
                      labelText: AppLocalizations.of(context)!.reTypePassword,
                      controller: confirmController,
                      obscureText: true,
                      validator: (value) {
                        if (confirmController.text != passwordController.text) {
                          return validations.passwordNotMatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    AuthButton(
                      mainText:
                          '${AppLocalizations.of(context)!.alreadyRegistered}? ',
                      subText: '${AppLocalizations.of(context)!.loginHere}!',
                      function: () {
                        Navigator.pushNamed(
                          context,
                          AppRouter.signIncreen,
                        );
                      },
                    )
                  ]),
                ),
              ),
            ),
            if (!isKeyboardVisible)
              AuthBottomBar(
                  mainText: AppLocalizations.of(context)!.saveAndContinue,
                  subText: AppLocalizations.of(context)!.dataMustBeReal,
                  onTapped: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseService()
                          .registerUser(
                              userName: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              confirmPassword: confirmController.text,
                              profileImg: pickedImage!,
                              context: context)
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
