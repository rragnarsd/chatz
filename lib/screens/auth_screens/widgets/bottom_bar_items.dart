import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/widgets/circle_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              style: TextStyles.style16Bold,
            ),
            Text(
              subText,
              style: TextStyles.style14,
            ),
          ],
        ),
        const Spacer(),
        CircleIconBtn(
          height: 40,
          btnColor: ConstColors.lightBlueCyan,
          iconColor: ConstColors.white,
          icon: const FaIcon(FontAwesomeIcons.arrowRight),
          onTapped: () => onTapped(),
        ),
      ]),
    );
  }
}
