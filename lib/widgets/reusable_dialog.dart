import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/screens/auth_screens/widgets/add_image_text.dart';
import 'package:flutter/material.dart';

class ReusableBottomSheet extends StatelessWidget {
  const ReusableBottomSheet({
    Key? key,
    required this.fromCamera,
    required this.fromGallery,
  }) : super(key: key);

  final Function()? fromCamera;
  final Function()? fromGallery;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: UIStyles.authBottomBar.copyWith(color: Colors.white),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 100,
                child: ListBody(children: [
                  InkWell(
                    onTap: () {},
                    child: const AddImageText(
                      icon: Icons.camera_alt,
                      text: 'Camera',
                      iconColor: ConstColors.darkerCyan,
                    ),
                  ),
                  const Divider(thickness: 1),
                  InkWell(
                    onTap: () {},
                    child: const AddImageText(
                      icon: Icons.image,
                      text: 'Gallery',
                      iconColor: ConstColors.darkerCyan,
                    ),
                  ),
                  const Divider(thickness: 1),
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
            ]),
      ),
    );
  }
}
