import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:flutter/material.dart';

class ReusableOutlineButton extends StatelessWidget {
  const ReusableOutlineButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 1),
      ),
      onPressed: () => Navigator.pop(context),
      child: Text(
        text,
        style: TextStyles.style14.copyWith(
          color: ConstColors.black87,
        ),
      ),
    );
  }
}
