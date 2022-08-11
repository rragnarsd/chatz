import 'package:chatz/constants/ui_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddImageIcon extends StatelessWidget {
  const AddImageIcon({
    Key? key,
    required this.iconSize,
    required this.backgroundColor,
    required this.iconColor,
  }) : super(key: key);

  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: UIStyles.iconDecoration.copyWith(
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FaIcon(
          FontAwesomeIcons.camera,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
