import 'package:chatz/constants/colors.dart';
import 'package:flutter/material.dart';

class AddImageIcon extends StatelessWidget {
  const AddImageIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.5),
        shape: BoxShape.circle,
        color: ConstColors.white,
      ),
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