import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/widgets/reusable_elevated_button.dart';
import 'package:chatz/widgets/reusable_outline_button.dart';

class ReusableDialog extends StatelessWidget {
  const ReusableDialog(
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
          ReusableOutlineButton(
            text: AppLocalizations.of(context)!.cancel,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: ReusableElevatedButton(
              text: AppLocalizations.of(context)!.save,
              function: () => onUpdate(),
            ),
          ),
        ]);
  }
}
