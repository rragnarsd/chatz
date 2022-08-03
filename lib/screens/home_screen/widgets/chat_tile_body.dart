import 'package:chatz/screens/home_screen/widgets/chat_tile.dart';
import 'package:flutter/material.dart';

class ChatTileBody extends StatelessWidget {
  const ChatTileBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Stack(clipBehavior: Clip.none, children: [
        Positioned(
          left: 20,
          right: -5,
          top: 8,
          child: Container(
            height: 80,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: const ChatTile(),
        ),
      ]),
    );
  }
}
