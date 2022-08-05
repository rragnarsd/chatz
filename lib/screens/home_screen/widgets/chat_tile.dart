import 'package:chatz/constants/colors.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(width: 1.5),
                shape: BoxShape.circle,
                color: ConstColors.shadeOfCyan),
            child: Image.asset(
              'assets/avatar.png',
              alignment: Alignment.topCenter,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Emma Bailey',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Hello how are you.. ?',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 0.8,
                  color: ConstColors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          Text(
            '23 min',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 0.8,
              color: ConstColors.black54,
            ),
          ),
          SizedBox(height: 4),
          CircleAvatar(radius: 6),
        ],
      )
    ]);
  }
}
