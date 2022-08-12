import 'package:chatz/screens/shared/widgets/app_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
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
      decoration: UIStyles.bottomSheet,
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const FaIcon(
            FontAwesomeIcons.minus,
            size: 30,
          ),
          AppListTile(
            icon: Icons.camera_alt,
            iconColor: ConstColors.darkerCyan,
            text: AppLocalizations.of(context)!.camera,
            function: fromCamera,
          ),
          AppListTile(
            icon: Icons.image,
            iconColor: ConstColors.darkerCyan,
            text: AppLocalizations.of(context)!.gallery,
            function: fromGallery,
          ),
          AppListTile(
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
