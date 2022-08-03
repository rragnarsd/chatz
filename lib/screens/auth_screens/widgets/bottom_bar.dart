import 'package:chatz/screens/auth_screens/widgets/bottom_bar_items.dart';
import 'package:flutter/material.dart';

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
      decoration: const BoxDecoration(
        color: Color(0xff9FD7B6),
        border: Border.fromBorderSide(
          BorderSide(color: Colors.black),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
        ),
      ),
      child: BottomBarItems(
        mainText: mainText,
        subText: subText,
        onTapped: () => onTapped(),
      ),
    );
  }
}
