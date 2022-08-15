import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.mainText,
    required this.subText,
    required this.function,
  }) : super(key: key);

  final String mainText;
  final String subText;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      splashColor: ConstColors.transparent,
      focusColor: ConstColors.transparent,
      child: Center(
        child: RichText(
          text: TextSpan(
            text: mainText,
            style: TextStyles.style14.copyWith(
              color: ConstColors.black87,
            ),
            children: <TextSpan>[
              TextSpan(
                text: subText,
                style: TextStyles.style14Bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
