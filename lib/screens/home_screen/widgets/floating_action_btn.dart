import 'package:chatz/constants/colors.dart';
import 'package:chatz/screens/search_screen/search_screen.dart';
import 'package:chatz/widgets/circle_icon_btn.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonAdd extends StatelessWidget {
  const FloatingActionButtonAdd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          color: Colors.grey.shade600,
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 5),
        ),
      ]),
      child: CircleIconBtn(
          btnColor: ConstColors.redOrange,
          iconColor: Colors.black,
          height: 56,
          icon: Icons.add,
          onTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          }),
    );
  }
}
