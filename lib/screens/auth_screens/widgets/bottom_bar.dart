import 'package:flutter/material.dart';

import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/screens/auth_screens/widgets/bottom_bar_items.dart';

class AuthBottomBar extends StatelessWidget {
  const AuthBottomBar({
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
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: UIStyles.authBottomBar,
      child: BottomBarItems(
        mainText: mainText,
        subText: subText,
        onTapped: () => onTapped(),
      ),
    );
  }
}
