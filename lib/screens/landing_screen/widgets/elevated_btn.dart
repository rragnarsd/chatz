import 'package:chatz/constants/colors.dart';
import 'package:flutter/material.dart';

class ElevatedBtn extends StatelessWidget {
  const ElevatedBtn({
    Key? key,
    required this.text,
    required this.btnColor,
    required this.textColor,
    required this.onTapped,
  }) : super(key: key);

  final String text;
  final Color btnColor;
  final Color textColor;
  final Function onTapped;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: ConstColors.black,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: () => onTapped(),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
