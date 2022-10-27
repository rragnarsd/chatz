import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:flutter/material.dart';

class AppElevatedBtn extends StatelessWidget {
  const AppElevatedBtn({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);

  final String text;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: const BorderSide(width: 1),
        backgroundColor: ConstColors.redOrange,
      ),
      onPressed: () => function(),
      child: Text(
        text,
        style: TextStyles.style14Bold,
      ),
    );
  }
}
