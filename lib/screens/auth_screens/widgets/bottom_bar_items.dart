import 'package:chatz/constants/colors.dart';
import 'package:chatz/widgets/circle_icon_btn.dart';
import 'package:flutter/material.dart';

class BottomBarItems extends StatelessWidget {
  const BottomBarItems({
    Key? key,
    required this.mainText,
    required this.subText,
    required this.onTapped,
  }) : super(key: key);

  final String mainText;
  final String subText;
  final Function onTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
            Text(
              subText,
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const Spacer(),
        CircleIconBtn(
          height: 40,
          btnColor: ConstColors.lightBlueCyan,
          iconColor: Colors.white,
          icon: Icons.arrow_forward,
          onTapped: () => onTapped(),
        ),
      ]),
    );
  }
}
