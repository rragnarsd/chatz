import 'package:chatz/widgets/avatar.dart';
import 'package:flutter/material.dart';

class SignUpAvatarRow extends StatelessWidget {
  const SignUpAvatarRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/arrow.png', height: 40),
        const SizedBox(width: 20),
        const SignUpAvatar(),
        const SizedBox(width: 20),
        RotatedBox(
          quarterTurns: 2,
          child: Image.asset('assets/arrow.png', height: 40),
        ),
      ],
    );
  }
}