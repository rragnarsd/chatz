import 'dart:io';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/screens/auth_screens/widgets/add_image_icon.dart';
import 'package:chatz/services/firebase.dart';
import 'package:chatz/widgets/reusable_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageRow extends StatefulWidget {
  const ProfileImageRow({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final dynamic userData;

  @override
  State<ProfileImageRow> createState() => _ProfileImageRowState();
}

class _ProfileImageRowState extends State<ProfileImageRow> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/arrow.png',
          height: 40,
        ),
        const SizedBox(width: 20),
        widget.userData['imgUrl'] != null
            ? Stack(children: [
                CircleAvatar(
                  radius: 64,
                  backgroundColor: ConstColors.greenCyan,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: pickedImage == null
                        ? NetworkImage(widget.userData['imgUrl'])
                            as ImageProvider
                        : FileImage(pickedImage!),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isDismissible: true,
                          context: context,
                          builder: (context) {
                            return ReusableBottomSheet(
                              fromCamera: () async {
                                await pickImageFromCamera()
                                    .then((value) => Navigator.pop(context));
                                if (pickedImage != null) {
                                  var imagePath = await FirebaseService()
                                      .uploadImageToStorage(pickedImage!);
                                  FirebaseService().updateImg(imagePath!);
                                }
                              },
                              fromGallery: () async {
                                await pickImageFromGallery()
                                    .then((value) => Navigator.pop(context));

                                if (pickedImage != null) {
                                  var imagePath = await FirebaseService()
                                      .uploadImageToStorage(pickedImage!);
                                  FirebaseService().updateImg(imagePath!);
                                }
                              },
                            );
                          });
                    },
                    child: const AddImageIcon(
                      iconSize: 22,
                      backgroundColor: ConstColors.white,
                      iconColor: ConstColors.black87,
                    ),
                  ),
                )
              ])
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

  Future pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = File(image!.path);
    });
  }

  Future pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = File(image!.path);
    });
  }
}
