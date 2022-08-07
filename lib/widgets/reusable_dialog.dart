import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/screens/auth_screens/widgets/add_image_text.dart';
import 'package:flutter/material.dart';

class ReusableDialog extends StatelessWidget {
  const ReusableDialog({
    Key? key,
    required this.fromCamera,
    required this.fromGallery,
  }) : super(key: key);

  final Function()? fromCamera;
  final Function()? fromGallery;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Choose option',
        style: TextStyles.style16Bold,
      ),
      content: SingleChildScrollView(
        child: ListBody(children: [
          InkWell(
            onTap: () => fromCamera,
            child: const AddImageText(
              icon: Icons.camera_alt,
              text: 'Camera',
              iconColor: ConstColors.darkerCyan,
            ),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () => fromGallery,
            child: const AddImageText(
              icon: Icons.image,
              text: 'Gallery',
              iconColor: ConstColors.darkerCyan,
            ),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const AddImageText(
              icon: Icons.cancel,
              text: 'Cancel',
              iconColor: Colors.red,
            ),
          ),
        ]),
      ),
    );
  }
}
