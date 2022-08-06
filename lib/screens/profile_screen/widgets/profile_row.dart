import 'package:chatz/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final dynamic userData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/arrow.png',
          height: 40,
        ),
        const SizedBox(width: 20),
        userData['imgUrl'] != null
            ? CircleAvatar(
                radius: 64,
                backgroundColor: ConstColors.greenCyan,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userData['imgUrl']),
                  radius: 60,
                ),
              )
            : const CircleAvatar(radius: 60),
        const SizedBox(width: 20),
        RotatedBox(
          quarterTurns: 2,
          child: Image.asset(
            'assets/arrow.png',
            height: 40,
          ),
        ),
      ],
    );
  }
}