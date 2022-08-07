import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/widgets/reusable_tile.dart';
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
      height: 200,
      decoration: UIStyles.authBottomBar.copyWith(color: Colors.white),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ReusableTile(
            icon: Icons.camera_alt,
            iconColor: ConstColors.darkerCyan,
            text: 'Camera',
            function: fromCamera,
          ),
          ReusableTile(
            icon: Icons.image,
            iconColor: ConstColors.darkerCyan,
            text: 'Gallery',
            function: fromGallery,
          ),
          ReusableTile(
            icon: Icons.cancel,
            iconColor: Colors.red,
            text: 'Cancel',
            function: () => Navigator.pop(context),
          ),
        ]),
      ),
    );
  }
}
