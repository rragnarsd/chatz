import 'package:chatz/screens/shared/widgets/app_elevated_btn.dart';
import 'package:chatz/screens/shared/widgets/app_outline_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:chatz/constants/text_styles.dart';

class AppDialog extends StatelessWidget {
  const AppDialog(
      {Key? key,
      required TextEditingController nameController,
      required this.onUpdate,
      required this.header,
      required this.hintText})
      : _nameController = nameController,
        super(key: key);

  final TextEditingController _nameController;
  final Function() onUpdate;
  final String header;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          header,
          style: TextStyles.style16Bold,
        ),
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
        actions: [
          AppOutlineBtn(
            text: AppLocalizations.of(context)!.cancel,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: AppElevatedBtn(
              text: AppLocalizations.of(context)!.save,
              function: () => onUpdate(),
            ),
          ),
        ]);
  }
}
