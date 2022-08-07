import 'package:chatz/constants/ui_styles.dart';
import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.camera_alt,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
