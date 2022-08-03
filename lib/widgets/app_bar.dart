import 'package:chatz/widgets/circle_icon_btn.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconBtn(
            height: 30,
            btnColor: const Color(0xffFFAD85),
            iconColor: Colors.black,
            icon: Icons.arrow_back,
            onTapped: () => Navigator.pop(context),
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
