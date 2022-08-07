import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/widgets/reusable_elevated_button.dart';
import 'package:chatz/widgets/reusable_outline_button.dart';
import 'package:flutter/material.dart';

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
          decoration: const InputDecoration(
            hintText: 'Enter new name...',
          ),
        ),
        actions: [
          const ReusableOutlineButton(
            text: 'Cancel',
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: ReusableElevatedButton(
              text: 'Save',
              function: () => onUpdate(),
            ),
          ),
        ]);
  }
}
