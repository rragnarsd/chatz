import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:flutter/material.dart';

class ChatTileBody extends StatelessWidget {
  const ChatTileBody({
    Key? key,
    required this.name,
    required this.message,
    required this.lastMessage,
  }) : super(key: key);

  final String name;
  final String message;
  final String lastMessage;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Positioned(
        left: 4,
        right: -4,
        top: 8,
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: UIStyles.chatDecoration.copyWith(
            color: ConstColors.lightShadeOrange,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: UIStyles.chatDecoration.copyWith(
          color: ConstColors.white,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5),
                    shape: BoxShape.circle,
                    color: ConstColors.shadeOfCyan,
                  ),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundColor: ConstColors.darkerCyan,
                  )),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyles.style14Bold,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyles.style12,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                lastMessage,
                style: TextStyles.style12,
              ),
              const SizedBox(height: 4),
              const CircleAvatar(radius: 6),
            ],
          )
        ]),
      ),
    ]);
  }
}
