import 'package:flutter/material.dart';

class AddImageText extends StatelessWidget {
  const AddImageText({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
