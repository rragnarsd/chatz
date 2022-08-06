import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/screens/chat_screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatTileBody extends StatelessWidget {
  const ChatTileBody({
    Key? key,
    this.stream,
    this.title,
  }) : super(key: key);

  final String? title;
  final Stream<QuerySnapshot<Object?>>? stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
          return InkWell(
            onTap: () {
              //TODO - Change
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(group: title),
                ),
              );
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(
                  left: 20,
                  right: -5,
                  top: 8,
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.7,
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Container(
                            //   height: 40,
                            //   decoration: BoxDecoration(
                            //       border: Border.all(width: 1.5),
                            //       shape: BoxShape.circle,
                            //       color: ConstColors.shadeOfCyan),
                            //   child: Image.network(
                            //     // imgUrl,
                            //     'assets/avatar.png',
                            //     alignment: Alignment.topCenter,
                            //   ),
                            // ),

                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title ?? '',
                                  style: TextStyles.style14Bold,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  snap.data?.docs.last['message'] ?? '',
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
                              snap.data?.docs.last['time'].toString() ?? '',
                              style: TextStyles.style12,
                            ),
                            const SizedBox(height: 4),
                            const CircleAvatar(radius: 6),
                          ],
                        )
                      ]),
                ),
              ]),
            ),
          );
        });
  }
}
