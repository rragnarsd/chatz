import 'package:flutter/material.dart';

class ReusableTile extends StatelessWidget {
  const ReusableTile({
    Key? key,
    required this.text,
    required this.iconColor,
    required this.icon,
    this.function,
  }) : super(key: key);

  final String text;
  final Color iconColor;
  final IconData icon;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 20),
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      onTap: function,
    );
  }
}
