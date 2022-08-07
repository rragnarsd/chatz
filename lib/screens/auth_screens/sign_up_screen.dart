import 'dart:developer';
import 'dart:io';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/validations.dart';
import 'package:chatz/data/models/user_model.dart';
import 'package:chatz/routes/router.dart';
import 'package:chatz/screens/auth_screens/widgets/add_image_icon.dart';

import 'package:chatz/screens/auth_screens/widgets/bottom_bar.dart';
import 'package:chatz/widgets/reusable_bottom_sheet.dart';
import 'package:chatz/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final Validations validations = Validations();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? pickedImage;

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
                                  : FileImage(pickedImage!),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      return ReusableBottomSheet(
                                        fromCamera: () {
                                          pickImageFromCamera();
                                          Navigator.pop(context);
                                        },
                                        fromGallery: () {
                                          pickImageFromGallery();
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
                      labelText: 'Username',
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
                        labelText: 'Email address',
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
                    AuthTextField(
                      labelText: 'Re-type Password',
                      controller: confirmController,
                      obscureText: true,
                      validator: (value) {
                        if (confirmController.text != passwordController.text) {
                          return validations.passwordNotMatch;
                        }
                        return null;
                      },
                    ),
                  ]),
                ),
              ),
            ),
            if (!isKeyboardVisible)
              AuthBottomBar(
                  mainText: 'Save and Continue',
                  subText: 'Your data must be real',
                  onTapped: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser(
                        userName: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        confirmPassword: confirmController.text,
                        profileImg: pickedImage!,
                      );
                    }
                  })
          ]),
        ),
      ),
    );
  }

  Future registerUser({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required File profileImg,
  }) async {
    if (password == confirmPassword) {
      try {
        await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) =>
                saveUserInfoToFirestore(userName, email, profileImg));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(validations.weakPassword),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(validations.accountExist),
            ),
          );
        }
      }
    } else {
      log('Passwords do not match');
    }
  }

  void saveUserInfoToFirestore(
      String userName, String email, File profileImg) async {
    User? user = auth.currentUser;

    String imageURL = await uploadImageToStorage(profileImg);
    UserModel model = UserModel(
      uid: auth.currentUser!.uid,
      name: userName,
      email: email,
      imgUrl: imageURL,
    );
    await firestore.collection('users').doc(user!.uid).set(model.toJson()).then(
        (value) => Navigator.pushNamedAndRemoveUntil(
            context, AppRouter.homeScreen, (route) => false));
  }

  void pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = File(image!.path);
    });
  }

  void pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = File(image!.path);
    });
  }

  Future<String> uploadImageToStorage(File imgUrl) async {
    Reference reference =
        storage.ref().child('images').child(auth.currentUser!.uid);
    UploadTask task = reference.putFile(imgUrl);
    TaskSnapshot snap = await task;
    String imageUrl = await snap.ref.getDownloadURL();
    return imageUrl;
  }
}
