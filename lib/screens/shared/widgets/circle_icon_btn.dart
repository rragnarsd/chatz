import 'package:chatz/constants/colors.dart';
import 'package:flutter/material.dart';

class CircleIconBtn extends StatelessWidget {
  const CircleIconBtn(
      {Key? key,
      required this.btnColor,
      required this.iconColor,
      required this.height,
      required this.icon,
      required this.onTapped})
      : super(key: key);

  final Color btnColor;
  final Color iconColor;
  final double height;
  final Widget icon;
  final Function onTapped;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(
            side: BorderSide(
              width: 1.5,
              color: ConstColors.black,
            ),
          ),
          backgroundColor: btnColor,
        ),
        child: icon,
        onPressed: () => onTapped(),
      ),
    );
  }
}
