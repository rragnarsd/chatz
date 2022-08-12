import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/widgets/reusable_tile.dart';

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
            text: AppLocalizations.of(context)!.camera,
            function: fromCamera,
          ),
          ReusableTile(
            icon: Icons.image,
            iconColor: ConstColors.darkerCyan,
            text: AppLocalizations.of(context)!.gallery,
            function: fromGallery,
          ),
          ReusableTile(
            icon: Icons.cancel,
            iconColor: Colors.red,
            text: AppLocalizations.of(context)!.cancel,
            function: () => Navigator.pop(context),
          ),
        ]),
      ),
    );
  }
}
