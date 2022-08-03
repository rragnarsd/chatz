import 'package:flutter/material.dart';

class SignUpAvatar extends StatelessWidget {
  const SignUpAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          shape: BoxShape.circle,
          color: const Color(0xff49b0aa),
        ),
        child: Image.asset(
          'assets/avatar.png',
          alignment: Alignment.topCenter,
        ),
      ),
      Positioned(
        bottom: 10,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1.5),
              shape: BoxShape.circle,
              color: Colors.white),
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.camera_alt,
              size: 14,
            ),
          ),
        ),
      )
    ]);
  }
}
