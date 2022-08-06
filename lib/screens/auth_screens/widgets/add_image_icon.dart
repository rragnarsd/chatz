import 'package:chatz/constants/ui_styles.dart';
import 'package:flutter/material.dart';

class AddImageIcon extends StatelessWidget {
  const AddImageIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: UIStyles.iconDecoration,
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Icon(
          Icons.camera_alt,
          size: 14,
        ),
      ),
    );
  }
}
